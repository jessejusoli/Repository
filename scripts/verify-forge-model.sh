#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LIFECYCLE="$ROOT_DIR/catalog/project-lifecycle.yml"
ARTIFACTS="$ROOT_DIR/catalog/project-artifacts.yml"
BLUEPRINTS="$ROOT_DIR/catalog/repository-blueprints.yml"
STANDARDS="$ROOT_DIR/catalog/standards.yml"
MCP="$ROOT_DIR/contracts/mcp/registry.yml"
RAG_PROFILE="$ROOT_DIR/contracts/rag/repository.rag-profile.yml"

failures=0
levels_file="$(mktemp)"
artifacts_file="$(mktemp)"
standards_file="$(mktemp)"
trap 'rm -f "$levels_file" "$artifacts_file" "$standards_file"' EXIT

info() {
  printf '[forge-model] %s\n' "$1"
}

fail() {
  printf '[forge-model] ERRO: %s\n' "$1" >&2
  failures=$((failures + 1))
}

require_file() {
  local path="$1"
  [[ -f "$ROOT_DIR/$path" ]] || fail "arquivo obrigatorio ausente: $path"
}

extract_section_refs() {
  local file="$1"
  local section="$2"

  awk -v section="$section" '
    $0 ~ "^[[:space:]]{4}" section ":" {
      in_refs = 1
      next
    }
    in_refs && /^[[:space:]]{6}- / {
      print $2
      next
    }
    in_refs && /^[[:space:]]{4}[a-zA-Z0-9_]+:/ {
      in_refs = 0
    }
  ' "$file"
}

info "validando arquivos base do Forge"
require_file "catalog/project-lifecycle.yml"
require_file "catalog/project-artifacts.yml"
require_file "docs/forge/README.md"
require_file "scripts/verify-forge-model.sh"

if [[ -f "$STANDARDS" ]]; then
  sed -n 's/^  - id: //p' "$STANDARDS" | sort > "$standards_file"
else
  fail "arquivo obrigatorio ausente: catalog/standards.yml"
fi

info "validando maturidade M0-M5"
if [[ -f "$LIFECYCLE" ]]; then
  grep -q '^schema_version: 1$' "$LIFECYCLE" || fail "catalog/project-lifecycle.yml sem schema_version 1"
  grep -q '^model: repository-forge-maturity$' "$LIFECYCLE" || fail "catalog/project-lifecycle.yml sem modelo repository-forge-maturity"
  sed -n 's/^  - id: //p' "$LIFECYCLE" | sort > "$levels_file"

  level_count="$(wc -l < "$levels_file" | tr -d ' ')"
  if [[ "$level_count" -ne 6 ]]; then
    fail "project-lifecycle deve declarar exatamente 6 niveis; encontrado: $level_count"
  fi

  for level in M0 M1 M2 M3 M4 M5; do
    grep -qx "$level" "$levels_file" || fail "nivel ausente em project-lifecycle: $level"
  done

  for field in name order purpose criteria required_evidence gates; do
    field_count="$(grep -c "^    $field:" "$LIFECYCLE" || true)"
    if [[ "$field_count" -ne 6 ]]; then
      fail "campo $field deve aparecer em todos os niveis; encontrado: $field_count de 6"
    fi
  done
fi

info "validando artefatos de projeto"
if [[ -f "$ARTIFACTS" ]]; then
  grep -q '^schema_version: 1$' "$ARTIFACTS" || fail "catalog/project-artifacts.yml sem schema_version 1"
  sed -n 's/^  - id: //p' "$ARTIFACTS" | sort > "$artifacts_file"
  artifact_count="$(wc -l < "$artifacts_file" | tr -d ' ')"

  if [[ "$artifact_count" -lt 20 ]]; then
    fail "project-artifacts deve declarar pelo menos 20 artefatos; encontrado: $artifact_count"
  fi

  for required_artifact in README BACKLOG ROADMAP SCOPE MVP SETUP USAGE_EXAMPLES CHANGELOG; do
    grep -qx "$required_artifact" "$artifacts_file" || fail "artefato essencial ausente: $required_artifact"
  done

  duplicate_count="$(sort "$artifacts_file" | uniq -d | wc -l | tr -d ' ')"
  if [[ "$duplicate_count" -gt 0 ]]; then
    fail "project-artifacts contem ids duplicados"
  fi

  for field in name min_maturity template standards_refs pillars applies_to_blueprints purpose; do
    field_count="$(grep -c "^    $field:" "$ARTIFACTS" || true)"
    if [[ "$field_count" -ne "$artifact_count" ]]; then
      fail "campo $field deve aparecer em todos os artefatos; encontrado: $field_count de $artifact_count"
    fi
  done

  while IFS= read -r template_path; do
    if [[ ! -f "$ROOT_DIR/$template_path" ]]; then
      fail "template de artefato inexistente: $template_path"
      continue
    fi

    first_line="$(head -n 1 "$ROOT_DIR/$template_path")"
    if [[ "$first_line" != \#* ]]; then
      fail "template de artefato sem H1: $template_path"
    fi
  done < <(sed -n 's/^    template: //p' "$ARTIFACTS")

  while IFS= read -r min_maturity; do
    grep -qx "$min_maturity" "$levels_file" || fail "artefato referencia maturidade inexistente: $min_maturity"
  done < <(sed -n 's/^    min_maturity: //p' "$ARTIFACTS")

  while IFS= read -r standard_ref; do
    [[ -z "$standard_ref" ]] && continue
    grep -qx "$standard_ref" "$standards_file" || fail "artefato referencia standard inexistente: $standard_ref"
  done < <(extract_section_refs "$ARTIFACTS" "standards_refs" | sort -u)
fi

info "validando blueprints contra maturidade e artefatos"
if [[ -f "$BLUEPRINTS" ]]; then
  blueprint_count="$(grep -c '^  - id:' "$BLUEPRINTS" || true)"
  minimum_count="$(grep -c '^    minimum_maturity:' "$BLUEPRINTS" || true)"
  artifact_refs_count="$(grep -c '^    artifact_refs:' "$BLUEPRINTS" || true)"

  [[ "$minimum_count" -eq "$blueprint_count" ]] || fail "cada blueprint deve declarar minimum_maturity"
  [[ "$artifact_refs_count" -eq "$blueprint_count" ]] || fail "cada blueprint deve declarar artifact_refs"

  while IFS= read -r minimum_maturity; do
    grep -qx "$minimum_maturity" "$levels_file" || fail "blueprint referencia maturidade inexistente: $minimum_maturity"
  done < <(sed -n 's/^    minimum_maturity: //p' "$BLUEPRINTS")

  while IFS= read -r artifact_ref; do
    [[ -z "$artifact_ref" ]] && continue
    grep -qx "$artifact_ref" "$artifacts_file" || fail "blueprint referencia artefato inexistente: $artifact_ref"
  done < <(extract_section_refs "$BLUEPRINTS" "artifact_refs" | sort -u)
else
  fail "arquivo obrigatorio ausente: catalog/repository-blueprints.yml"
fi

info "validando CLI, MCP e RAG"
grep -q 'list-maturity-levels' "$ROOT_DIR/tooling/repository-forge/src/index.ts" || fail "Forge CLI sem comando list-maturity-levels"
grep -q 'list-project-artifacts' "$ROOT_DIR/tooling/repository-forge/src/index.ts" || fail "Forge CLI sem comando list-project-artifacts"
grep -q 'maturityLevel' "$ROOT_DIR/tooling/repository-forge/src/plan.ts" || fail "Forge plan sem maturityLevel"
grep -q 'outputFormat' "$ROOT_DIR/tooling/repository-forge/src/plan.ts" || fail "Forge plan sem outputFormat"

grep -q 'list_maturity_levels' "$ROOT_DIR/services/repository-mcp/src/tools.ts" || fail "MCP service sem tool list_maturity_levels"
grep -q 'list_project_artifacts' "$ROOT_DIR/services/repository-mcp/src/tools.ts" || fail "MCP service sem tool list_project_artifacts"
grep -q 'repository://catalog/project-lifecycle' "$ROOT_DIR/services/repository-mcp/src/resources.ts" || fail "MCP service sem recurso project-lifecycle"
grep -q 'repository://catalog/project-artifacts' "$ROOT_DIR/services/repository-mcp/src/resources.ts" || fail "MCP service sem recurso project-artifacts"
grep -q 'repository://forge/maturity/{level}' "$ROOT_DIR/services/repository-mcp/src/resources.ts" || fail "MCP service sem recurso forge/maturity/{level}"

grep -q 'list_maturity_levels' "$MCP" || fail "MCP registry sem tool list_maturity_levels"
grep -q 'list_project_artifacts' "$MCP" || fail "MCP registry sem tool list_project_artifacts"
grep -q 'repository://catalog/project-lifecycle' "$MCP" || fail "MCP registry sem recurso project-lifecycle"
grep -q 'repository://catalog/project-artifacts' "$MCP" || fail "MCP registry sem recurso project-artifacts"
grep -q 'repository://forge/maturity/{level}' "$MCP" || fail "MCP registry sem recurso forge/maturity/{level}"

grep -q '    - docs/forge/' "$RAG_PROFILE" || fail "RAG profile deve indexar docs/forge/"
grep -q '    - docs/templates/lifecycle/' "$RAG_PROFILE" || fail "RAG profile deve indexar docs/templates/lifecycle/"
grep -q '    - catalog/project-lifecycle.yml' "$RAG_PROFILE" || fail "RAG profile deve indexar catalog/project-lifecycle.yml"
grep -q '    - catalog/project-artifacts.yml' "$RAG_PROFILE" || fail "RAG profile deve indexar catalog/project-artifacts.yml"

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
