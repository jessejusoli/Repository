#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

failures=0

info() {
  printf '[repository] %s\n' "$1"
}

fail() {
  printf '[repository] ERRO: %s\n' "$1" >&2
  failures=$((failures + 1))
}

require_file() {
  local path="$1"
  [[ -f "$ROOT_DIR/$path" ]] || fail "arquivo obrigatorio ausente: $path"
}

require_dir() {
  local path="$1"
  [[ -d "$ROOT_DIR/$path" ]] || fail "diretorio obrigatorio ausente: $path"
}

required_files=(
  "README.md"
  "CONTRIBUTING.md"
  "SECURITY.md"
  "CODE_OF_CONDUCT.md"
  "CHANGELOG.md"
  ".editorconfig"
  ".gitattributes"
  ".gitignore"
  ".github/CODEOWNERS"
  ".github/dependabot.yml"
  ".github/workflows/cd.yaml"
  ".github/workflows/ci.yaml"
  ".github/workflows/repository-health.yml"
  "AGENTS.md"
  "references.md"
  "catalog/projects.yml"
  "catalog/owners.yml"
  "catalog/pillars.yml"
  "catalog/pillar-items.yml"
  "catalog/repository-self-assessment.yml"
  "contracts/README.md"
  "contracts/openapi/README.md"
  "contracts/postman/README.md"
  "contracts/mcp/README.md"
  "contracts/rag/README.md"
  "AI_AGENTS/README.md"
  "AI_AGENTS/registry.yml"
  "scripts/verify-repository.sh"
  "scripts/verify-pillar-coverage.sh"
  "scripts/verify-pillar-docs.sh"
  "scripts/verify-contracts.sh"
  "scripts/verify-agents.sh"
  "docs/architecture/monorepo.md"
  "docs/architecture/universal-project-model.md"
  "docs/architecture/api-contracts.md"
  "docs/architecture/ai-systems.md"
  "docs/governance/branching.md"
  "docs/governance/code-review.md"
  "docs/governance/release-management.md"
  "docs/governance/security-model.md"
  "docs/governance/documentation-standards.md"
  "docs/governance/compliance-matrix.md"
  "docs/automation/github.md"
  "docs/automation/ci-cd.md"
  "docs/automation/ai-agents.md"
  "docs/checklists/universal-project-readiness.md"
  "docs/pillars/README.md"
)

required_dirs=(
  "apps"
  "packages"
  "services"
  "infra"
  "tooling"
  "examples"
  "catalog"
  "contracts"
  "AI_AGENTS"
  "docs"
  "docs/diagrams"
  "docs/pillars"
  "scripts"
  ".github"
)

info "validando estrutura obrigatoria"
for path in "${required_files[@]}"; do
  require_file "$path"
done

for path in "${required_dirs[@]}"; do
  require_dir "$path"
done

info "validando documentos markdown"
while IFS= read -r file; do
  relative_path="${file#"$ROOT_DIR/"}"

  if [[ ! -s "$file" ]]; then
    fail "markdown vazio: $relative_path"
    continue
  fi

  first_line="$(head -n 1 "$file")"
  if [[ "$first_line" != \#* ]]; then
    fail "markdown sem titulo H1 na primeira linha: $relative_path"
  fi

  if grep -n '[[:blank:]]$' "$file" >/dev/null; then
    fail "markdown com espaco em fim de linha: $relative_path"
  fi
done < <(
  find "$ROOT_DIR" \
    -type f \
    -name '*.md' \
    -not -path "$ROOT_DIR/.git/*" \
    | sort
)

info "validando catalogos"
grep -q '^schema_version: 1$' "$ROOT_DIR/catalog/projects.yml" || fail "catalog/projects.yml sem schema_version 1"
grep -q '^schema_version: 1$' "$ROOT_DIR/catalog/owners.yml" || fail "catalog/owners.yml sem schema_version 1"
grep -q '^schema_version: 1$' "$ROOT_DIR/catalog/pillars.yml" || fail "catalog/pillars.yml sem schema_version 1"
grep -q '^schema_version: 1$' "$ROOT_DIR/catalog/pillar-items.yml" || fail "catalog/pillar-items.yml sem schema_version 1"
grep -q '^schema_version: 1$' "$ROOT_DIR/catalog/repository-self-assessment.yml" || fail "catalog/repository-self-assessment.yml sem schema_version 1"

pillar_count="$(grep -c '^  - id:' "$ROOT_DIR/catalog/pillars.yml")"
if [[ "$pillar_count" -ne 13 ]]; then
  fail "catalog/pillars.yml deve declarar 13 pilares; encontrado: $pillar_count"
fi

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
