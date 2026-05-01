#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CATALOG="$ROOT_DIR/catalog/repository-blueprints.yml"
failures=0

info() {
  printf '[blueprints] %s\n' "$1"
}

fail() {
  printf '[blueprints] ERRO: %s\n' "$1" >&2
  failures=$((failures + 1))
}

info "validando blueprints de repositorio"
[[ -f "$CATALOG" ]] || fail "arquivo ausente: catalog/repository-blueprints.yml"

if [[ -f "$CATALOG" ]]; then
  grep -q '^schema_version: 1$' "$CATALOG" || fail "schema_version ausente"
  blueprint_count="$(grep -c '^  - id:' "$CATALOG")"
  type_count="$(grep -c '^    type:' "$CATALOG")"
  name_count="$(grep -c '^    name:' "$CATALOG")"
  doc_path_count="$(grep -c '^    doc_path:' "$CATALOG")"
  minimum_maturity_count="$(grep -c '^    minimum_maturity:' "$CATALOG")"
  artifact_refs_count="$(grep -c '^    artifact_refs:' "$CATALOG")"

  [[ "$blueprint_count" -ge 8 ]] || fail "catalog/repository-blueprints.yml deve conter pelo menos 8 blueprints"
  [[ "$type_count" -eq "$blueprint_count" ]] || fail "blueprint sem type"
  [[ "$name_count" -eq "$blueprint_count" ]] || fail "blueprint sem name"
  [[ "$doc_path_count" -eq "$blueprint_count" ]] || fail "blueprint sem doc_path"
  [[ "$minimum_maturity_count" -eq "$blueprint_count" ]] || fail "blueprint sem minimum_maturity"
  [[ "$artifact_refs_count" -eq "$blueprint_count" ]] || fail "blueprint sem artifact_refs"

  while IFS= read -r doc_path; do
    [[ -f "$ROOT_DIR/$doc_path" ]] || fail "doc_path inexistente: $doc_path"
  done < <(sed -n 's/^    doc_path: //p' "$CATALOG")
fi

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
