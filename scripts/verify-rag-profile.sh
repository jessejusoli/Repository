#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE="$ROOT_DIR/contracts/rag/repository.rag-profile.yml"
failures=0

info() {
  printf '[rag-profile] %s\n' "$1"
}

fail() {
  printf '[rag-profile] ERRO: %s\n' "$1" >&2
  failures=$((failures + 1))
}

info "validando perfil RAG do repositorio"
[[ -f "$PROFILE" ]] || fail "arquivo ausente: contracts/rag/repository.rag-profile.yml"

if [[ -f "$PROFILE" ]]; then
  grep -q '^schema_version: 1$' "$PROFILE" || fail "schema_version ausente"
  for source in "AGENTS.md" "README.md" "references.md" "catalog/" "contracts/" "docs/"; do
    grep -q "    - $source" "$PROFILE" || fail "fonte ausente no corpus: $source"
  done
  grep -q '^retrieval:' "$PROFILE" || fail "retrieval ausente"
  grep -q '^evaluation:' "$PROFILE" || fail "evaluation ausente"
  grep -q '^safety:' "$PROFILE" || fail "safety ausente"
  grep -q 'index_storage: .rag/repository-index.json' "$PROFILE" || fail "index_storage deve apontar para .rag/"
  grep -q 'no-generated-index-in-git' "$PROFILE" || fail "controle no-generated-index-in-git ausente"
fi

grep -q '^.rag/$' "$ROOT_DIR/.gitignore" || fail ".gitignore deve ignorar .rag/"

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
