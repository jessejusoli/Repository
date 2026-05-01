#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

failures=0

info() {
  printf '[contracts] %s\n' "$1"
}

fail() {
  printf '[contracts] ERRO: %s\n' "$1" >&2
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

info "validando estrutura de contratos"
require_dir "contracts"
require_dir "contracts/openapi"
require_dir "contracts/postman"
require_dir "contracts/mcp"
require_dir "contracts/rag"
require_file "contracts/README.md"
require_file "contracts/openapi/README.md"
require_file "contracts/openapi/repository.template.openapi.yaml"
require_file "contracts/openapi/repository.forge.openapi.yaml"
require_file "contracts/postman/README.md"
require_file "contracts/postman/repository.template.postman_collection.json"
require_file "contracts/postman/repository.forge.postman_collection.json"
require_file "contracts/mcp/README.md"
require_file "contracts/mcp/registry.yml"
require_file "contracts/rag/README.md"
require_file "contracts/rag/rag-profile.template.yml"
require_file "contracts/rag/repository.rag-profile.yml"

info "validando OpenAPI"
while IFS= read -r file; do
  relative_path="${file#"$ROOT_DIR/"}"
  grep -q '^openapi:' "$file" || fail "OpenAPI sem campo openapi: $relative_path"
  grep -q '^info:' "$file" || fail "OpenAPI sem campo info: $relative_path"
  grep -q '^paths:' "$file" || fail "OpenAPI sem campo paths: $relative_path"
done < <(find "$ROOT_DIR/contracts/openapi" -type f \( -name '*.yaml' -o -name '*.yml' \) | sort)

info "validando Postman"
while IFS= read -r file; do
  relative_path="${file#"$ROOT_DIR/"}"
  grep -q '"schema":' "$file" || fail "Postman collection sem schema: $relative_path"
  grep -q 'v2.1.0' "$file" || fail "Postman collection deve usar formato v2.1.0: $relative_path"
  grep -q '"item":' "$file" || fail "Postman collection sem item: $relative_path"
done < <(find "$ROOT_DIR/contracts/postman" -type f -name '*.json' | sort)

info "validando MCP"
grep -q '^schema_version: 1$' "$ROOT_DIR/contracts/mcp/registry.yml" || fail "MCP registry sem schema_version 1"
grep -q '^servers:' "$ROOT_DIR/contracts/mcp/registry.yml" || fail "MCP registry sem servers"
grep -q '^clients:' "$ROOT_DIR/contracts/mcp/registry.yml" || fail "MCP registry sem clients"

info "validando RAG"
grep -q '^schema_version: 1$' "$ROOT_DIR/contracts/rag/rag-profile.template.yml" || fail "RAG profile sem schema_version 1"
grep -q '^retrieval:' "$ROOT_DIR/contracts/rag/rag-profile.template.yml" || fail "RAG profile sem retrieval"
grep -q '^evaluation:' "$ROOT_DIR/contracts/rag/rag-profile.template.yml" || fail "RAG profile sem evaluation"
grep -q '^safety:' "$ROOT_DIR/contracts/rag/rag-profile.template.yml" || fail "RAG profile sem safety"

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
