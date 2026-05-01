#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OPENAPI="$ROOT_DIR/contracts/openapi/repository.forge.openapi.yaml"
POSTMAN="$ROOT_DIR/contracts/postman/repository.forge.postman_collection.json"
MCP="$ROOT_DIR/contracts/mcp/registry.yml"
failures=0

info() {
  printf '[api-contracts] %s\n' "$1"
}

fail() {
  printf '[api-contracts] ERRO: %s\n' "$1" >&2
  failures=$((failures + 1))
}

info "validando contratos Repository Forge"
[[ -f "$OPENAPI" ]] || fail "OpenAPI ausente"
[[ -f "$POSTMAN" ]] || fail "Postman ausente"
[[ -f "$MCP" ]] || fail "MCP registry ausente"

if [[ -f "$OPENAPI" ]]; then
  grep -q '^openapi: 3.2.0$' "$OPENAPI" || fail "OpenAPI deve usar 3.2.0"
  for operation in listBlueprints inspectBlueprint listMaturityLevels listProjectArtifacts generateRepositoryPlan validateRepository; do
    grep -q "operationId: $operation" "$OPENAPI" || fail "OpenAPI sem operationId $operation"
  done
  grep -q 'maturityLevel:' "$OPENAPI" || fail "OpenAPI sem maturityLevel no plano"
  grep -q 'outputFormat:' "$OPENAPI" || fail "OpenAPI sem outputFormat no plano"
fi

if [[ -f "$POSTMAN" ]]; then
  for request in "List blueprints" "Inspect blueprint" "List maturity levels" "List project artifacts" "Generate repository plan" "Validate repository"; do
    grep -q "\"name\": \"$request\"" "$POSTMAN" || fail "Postman sem request $request"
  done
  grep -q 'maturityLevel' "$POSTMAN" || fail "Postman sem maturityLevel no plano"
  grep -q 'outputFormat' "$POSTMAN" || fail "Postman sem outputFormat no plano"
fi

if [[ -f "$MCP" ]]; then
  for tool in list_maturity_levels list_project_artifacts list_templates inspect_template generate_repository_plan validate_repository search_pillars search_governance; do
    grep -q "      - $tool" "$MCP" || fail "MCP registry sem tool $tool"
  done
  grep -q 'repository://catalog/pillars' "$MCP" || fail "MCP registry sem recurso de pilares"
  grep -q 'repository://catalog/stacks' "$MCP" || fail "MCP registry sem recurso de stacks"
  grep -q 'repository://catalog/standards' "$MCP" || fail "MCP registry sem recurso de standards"
  grep -q 'repository://catalog/project-lifecycle' "$MCP" || fail "MCP registry sem recurso project-lifecycle"
  grep -q 'repository://catalog/project-artifacts' "$MCP" || fail "MCP registry sem recurso project-artifacts"
  grep -q 'repository://standards/{standard_id}' "$MCP" || fail "MCP registry sem recurso de pocket guide de standard"
  grep -q 'repository://pillars/{pillar}/standards' "$MCP" || fail "MCP registry sem recurso de standards por pilar"
  grep -q 'repository://forge/maturity/{level}' "$MCP" || fail "MCP registry sem recurso forge/maturity/{level}"
fi

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
