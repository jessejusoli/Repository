#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

failures=0

info() {
  printf '[pillar-docs] %s\n' "$1"
}

fail() {
  printf '[pillar-docs] ERRO: %s\n' "$1" >&2
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

PILLARS_ROOT="$ROOT_DIR/docs/pillars"
CATALOG_FILE="$ROOT_DIR/catalog/pillar-items.yml"

pillar_dirs=(
  "front-end"
  "back-end"
  "infrastructure"
  "devops"
  "security"
  "quality-assurance"
  "data"
  "product-ux"
  "architecture"
  "sre"
  "it-governance"
  "developer-experience"
  "sustainability"
)

info "validando diretorios dos 13 pilares"
require_file "docs/pillars/README.md"
require_file "catalog/pillar-items.yml"

pillar_dir_count="$(find "$PILLARS_ROOT" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
if [[ "$pillar_dir_count" -ne 13 ]]; then
  fail "docs/pillars deve conter exatamente 13 diretorios; encontrado: $pillar_dir_count"
fi

for pillar_dir in "${pillar_dirs[@]}"; do
  require_dir "docs/pillars/$pillar_dir"
  require_file "docs/pillars/$pillar_dir/README.md"

  item_count="$(find "$PILLARS_ROOT/$pillar_dir" -maxdepth 1 -type f -name '*.md' ! -name 'README.md' | wc -l | tr -d ' ')"
  if [[ "$item_count" -ne 20 ]]; then
    fail "pilar $pillar_dir deve conter 20 arquivos de itens; encontrado: $item_count"
  fi
done

info "validando catalogo de itens"
grep -q '^schema_version: 1$' "$CATALOG_FILE" || fail "catalog/pillar-items.yml sem schema_version 1"
grep -q '^expected_pillars: 13$' "$CATALOG_FILE" || fail "catalog/pillar-items.yml sem expected_pillars 13"
grep -q '^expected_items: 260$' "$CATALOG_FILE" || fail "catalog/pillar-items.yml sem expected_items 260"

catalog_item_count="$(grep -c '^  - id:' "$CATALOG_FILE")"
doc_path_count="$(grep -c '^    doc_path:' "$CATALOG_FILE")"
status_count="$(grep -c '^    status:' "$CATALOG_FILE")"
evidence_count="$(grep -c '^    evidence:' "$CATALOG_FILE")"

[[ "$catalog_item_count" -eq 260 ]] || fail "catalog/pillar-items.yml deve conter 260 itens; encontrado: $catalog_item_count"
[[ "$doc_path_count" -eq 260 ]] || fail "catalog/pillar-items.yml deve conter 260 doc_path; encontrado: $doc_path_count"
[[ "$status_count" -eq 260 ]] || fail "catalog/pillar-items.yml deve conter 260 status; encontrado: $status_count"
[[ "$evidence_count" -eq 260 ]] || fail "catalog/pillar-items.yml deve conter 260 evidence; encontrado: $evidence_count"

if grep -n '^    status:[[:space:]]*$' "$CATALOG_FILE" >/dev/null; then
  fail "catalog/pillar-items.yml contem item com status vazio"
fi

if grep -n '^    doc_path:[[:space:]]*$' "$CATALOG_FILE" >/dev/null; then
  fail "catalog/pillar-items.yml contem item com doc_path vazio"
fi

evidence_entry_count="$(grep -c '^      - ' "$CATALOG_FILE")"
[[ "$evidence_entry_count" -ge 260 ]] || fail "catalog/pillar-items.yml contem item sem evidencia listada"

while IFS= read -r doc_path; do
  [[ -f "$ROOT_DIR/$doc_path" ]] || fail "doc_path inexistente no catalogo: $doc_path"
done < <(sed -n 's/^    doc_path: //p' "$CATALOG_FILE")

info "validando markdown dos pilares"
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
done < <(find "$PILLARS_ROOT" -type f -name '*.md' | sort)

total_item_docs="$(find "$PILLARS_ROOT" -mindepth 2 -maxdepth 2 -type f -name '*.md' ! -name 'README.md' | wc -l | tr -d ' ')"
if [[ "$total_item_docs" -ne 260 ]]; then
  fail "docs/pillars deve conter 260 arquivos de itens; encontrado: $total_item_docs"
fi

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
