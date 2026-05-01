#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STANDARDS="$ROOT_DIR/catalog/standards.yml"
BLUEPRINTS="$ROOT_DIR/catalog/repository-blueprints.yml"
STACKS="$ROOT_DIR/catalog/stacks.yml"
PILLARS="$ROOT_DIR/catalog/pillars.yml"
RAG_PROFILE="$ROOT_DIR/contracts/rag/repository.rag-profile.yml"

failures=0
standard_ids_file="$(mktemp)"
referenced_standards_file="$(mktemp)"
trap 'rm -f "$standard_ids_file" "$referenced_standards_file"' EXIT

info() {
  printf '[standards] %s\n' "$1"
}

fail() {
  printf '[standards] ERRO: %s\n' "$1" >&2
  failures=$((failures + 1))
}

require_file() {
  local path="$1"
  [[ -f "$ROOT_DIR/$path" ]] || fail "arquivo obrigatorio ausente: $path"
}

extract_standards_refs() {
  local file="$1"
  awk '
    /^[[:space:]]{4}standards_refs:/ {
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

info "validando catalogo central de standards"
require_file "catalog/standards.yml"
require_file "catalog/license-options.yml"
require_file "docs/standards/README.md"
require_file "docs/templates/STANDARD.md"
require_file "LICENSE.template.md"

if [[ -f "$ROOT_DIR/docs/standards/README.md" ]]; then
  grep -q '^## By Pillar$' "$ROOT_DIR/docs/standards/README.md" || fail "docs/standards/README.md sem backlinks por pilar"
  grep -q '^## By Blueprint$' "$ROOT_DIR/docs/standards/README.md" || fail "docs/standards/README.md sem backlinks por blueprint"
  grep -q '^## By Stack$' "$ROOT_DIR/docs/standards/README.md" || fail "docs/standards/README.md sem backlinks por stack"
  grep -q '^## By Artifact$' "$ROOT_DIR/docs/standards/README.md" || fail "docs/standards/README.md sem backlinks por artefato"
fi

if [[ -f "$STANDARDS" ]]; then
  grep -q '^schema_version: 1$' "$STANDARDS" || fail "catalog/standards.yml sem schema_version 1"
  grep -q '^standards:$' "$STANDARDS" || fail "catalog/standards.yml sem raiz standards"

  sed -n 's/^  - id: //p' "$STANDARDS" | sort > "$standard_ids_file"
  standard_count="$(wc -l < "$standard_ids_file" | tr -d ' ')"

  if [[ "$standard_count" -lt 19 ]]; then
    fail "catalog/standards.yml deve declarar ao menos 19 standards iniciais; encontrado: $standard_count"
  fi

  duplicate_count="$(sort "$standard_ids_file" | uniq -d | wc -l | tr -d ' ')"
  if [[ "$duplicate_count" -gt 0 ]]; then
    fail "catalog/standards.yml contem ids duplicados"
  fi

  for field in name type status applies_to official_url pocket_guide related_pillars related_blueprints adoption_criteria; do
    field_count="$(grep -c "^    $field:" "$STANDARDS" || true)"
    if [[ "$field_count" -ne "$standard_count" ]]; then
      fail "campo $field deve aparecer em todos os standards; encontrado: $field_count de $standard_count"
    fi
  done

  while IFS='|' read -r id url; do
    if [[ ! "$url" =~ ^https?:// ]]; then
      fail "standard $id deve ter official_url http(s)"
    fi
  done < <(
    awk '
      /^  - id:/ { id = $3 }
      /^    official_url:/ { print id "|" $2 }
    ' "$STANDARDS"
  )

  while IFS='|' read -r id guide; do
    if [[ "$guide" != docs/standards/*.md ]]; then
      fail "standard $id deve apontar pocket_guide para docs/standards/"
    fi

    if [[ ! -f "$ROOT_DIR/$guide" ]]; then
      fail "standard $id aponta pocket_guide inexistente: $guide"
      continue
    fi

    first_line="$(head -n 1 "$ROOT_DIR/$guide")"
    if [[ "$first_line" != \#* ]]; then
      fail "pocket guide sem H1 na primeira linha: $guide"
    fi
  done < <(
    awk '
      /^  - id:/ { id = $3 }
      /^    pocket_guide:/ { print id "|" $2 }
    ' "$STANDARDS"
  )

  while IFS= read -r id; do
    fail "standard $id sem related_pillars preenchido"
  done < <(
    awk '
      function flush() {
        if (id != "" && related_pillars == 0) {
          print id
        }
      }
      /^  - id:/ {
        flush()
        id = $3
        section = ""
        related_pillars = 0
        next
      }
      /^    related_pillars:/ {
        section = "related_pillars"
        next
      }
      /^    [a-zA-Z0-9_]+:/ {
        section = ""
      }
      section == "related_pillars" && /^      - / {
        related_pillars = 1
      }
      END {
        flush()
      }
    ' "$STANDARDS"
  )

  while IFS= read -r id; do
    fail "standard $id sem adoption_criteria preenchido"
  done < <(
    awk '
      function flush() {
        if (id != "" && adoption_criteria == 0) {
          print id
        }
      }
      /^  - id:/ {
        flush()
        id = $3
        section = ""
        adoption_criteria = 0
        next
      }
      /^    adoption_criteria:/ {
        section = "adoption_criteria"
        next
      }
      /^    [a-zA-Z0-9_]+:/ {
        section = ""
      }
      section == "adoption_criteria" && /^      - / {
        adoption_criteria = 1
      }
      END {
        flush()
      }
    ' "$STANDARDS"
  )
fi

info "validando referencias de standards em blueprints e stacks"
if [[ -f "$BLUEPRINTS" ]]; then
  blueprint_count="$(grep -c '^  - id:' "$BLUEPRINTS" || true)"
  blueprint_refs_count="$(grep -c '^    standards_refs:' "$BLUEPRINTS" || true)"
  if [[ "$blueprint_refs_count" -ne "$blueprint_count" ]]; then
    fail "cada blueprint deve declarar standards_refs; encontrado: $blueprint_refs_count de $blueprint_count"
  fi

  extract_standards_refs "$BLUEPRINTS" >> "$referenced_standards_file"
fi

if [[ -f "$STACKS" ]]; then
  stack_count="$(grep -c '^  - id:' "$STACKS" || true)"
  stack_refs_count="$(grep -c '^    standards_refs:' "$STACKS" || true)"
  if [[ "$stack_refs_count" -ne "$stack_count" ]]; then
    fail "cada stack deve declarar standards_refs; encontrado: $stack_refs_count de $stack_count"
  fi

  extract_standards_refs "$STACKS" >> "$referenced_standards_file"
fi

while IFS= read -r standard_ref; do
  [[ -z "$standard_ref" ]] && continue
  if ! grep -qx "$standard_ref" "$standard_ids_file"; then
    fail "standards_refs aponta para standard inexistente: $standard_ref"
  fi
done < <(sort -u "$referenced_standards_file")

info "validando cobertura por pilar"
if [[ -f "$PILLARS" && -f "$STANDARDS" ]]; then
  while IFS= read -r pillar_id; do
    if ! grep -q "      - $pillar_id$" "$STANDARDS"; then
      fail "pilar sem standard relacionado: $pillar_id"
    fi
  done < <(sed -n 's/^  - id: //p' "$PILLARS")
fi

while IFS= read -r pillar_readme; do
  relative_path="${pillar_readme#"$ROOT_DIR/"}"
  grep -q '^## Padroes Relacionados$' "$pillar_readme" || fail "README de pilar sem Padroes Relacionados: $relative_path"
  related_count="$(awk '/^## Padroes Relacionados$/{in_section=1; next} in_section && /^## /{in_section=0} in_section && /^- /{count++} END{print count + 0}' "$pillar_readme")"
  if [[ "$related_count" -eq 0 ]]; then
    fail "README de pilar sem standards relacionados: $relative_path"
  fi
done < <(
  find "$ROOT_DIR/docs/pillars" -mindepth 2 -maxdepth 2 -type f -name README.md | sort
)

item_count=0
item_standard_count=0
while IFS= read -r item_doc; do
  item_count=$((item_count + 1))
  if grep -q '^## Padroes Relacionados$' "$item_doc"; then
    item_standard_count=$((item_standard_count + 1))
  fi
done < <(
  find "$ROOT_DIR/docs/pillars" -mindepth 2 -maxdepth 2 -type f -name '*.md' ! -name README.md | sort
)
if [[ "$item_standard_count" -ne "$item_count" ]]; then
  fail "cada item de pilar deve ter Padroes Relacionados; encontrado: $item_standard_count de $item_count"
fi

info "validando RAG e MCP para standards"
if [[ -f "$RAG_PROFILE" ]]; then
  grep -q '    - docs/standards/' "$RAG_PROFILE" || fail "RAG profile deve indexar docs/standards/"
  grep -q '    - catalog/standards.yml' "$RAG_PROFILE" || fail "RAG profile deve indexar catalog/standards.yml"
else
  fail "arquivo ausente: contracts/rag/repository.rag-profile.yml"
fi

grep -q 'repository://catalog/standards' "$ROOT_DIR/contracts/mcp/registry.yml" || fail "MCP registry sem recurso catalog/standards"
grep -q 'repository://standards/{standard_id}' "$ROOT_DIR/contracts/mcp/registry.yml" || fail "MCP registry sem recurso standards/{standard_id}"
grep -q 'repository://pillars/{pillar}/standards' "$ROOT_DIR/contracts/mcp/registry.yml" || fail "MCP registry sem recurso pillars/{pillar}/standards"

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
