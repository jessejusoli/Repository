#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

failures=0

info() {
  printf '[agents] %s\n' "$1"
}

fail() {
  printf '[agents] ERRO: %s\n' "$1" >&2
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

info "validando instrucoes de agentes"
require_file "AGENTS.md"
require_dir "AI_AGENTS"
require_file "AI_AGENTS/README.md"
require_file "AI_AGENTS/registry.yml"
require_file "AI_AGENTS/modes/README.md"
require_file "AI_AGENTS/subagents/README.md"
require_file "AI_AGENTS/skills/README.md"
require_file "AI_AGENTS/mcp/README.md"
require_file "AI_AGENTS/rag/README.md"
require_file "AI_AGENTS/policies/README.md"

if [[ -f "$ROOT_DIR/AGENTS.md" ]]; then
  grep -q '^# AGENTS.md$' "$ROOT_DIR/AGENTS.md" || fail "AGENTS.md deve iniciar com H1"
  grep -q 'make verify' "$ROOT_DIR/AGENTS.md" || fail "AGENTS.md deve listar verificacao principal"
  grep -q '13 Pillars' "$ROOT_DIR/AGENTS.md" || fail "AGENTS.md deve referenciar os 13 pilares"
fi

if [[ -f "$ROOT_DIR/AI_AGENTS/registry.yml" ]]; then
  grep -q '^schema_version: 1$' "$ROOT_DIR/AI_AGENTS/registry.yml" || fail "AI_AGENTS/registry.yml sem schema_version 1"
  grep -q '^modes:' "$ROOT_DIR/AI_AGENTS/registry.yml" || fail "AI_AGENTS/registry.yml sem modes"
  grep -q '^subagents:' "$ROOT_DIR/AI_AGENTS/registry.yml" || fail "AI_AGENTS/registry.yml sem subagents"
  grep -q '^skills:' "$ROOT_DIR/AI_AGENTS/registry.yml" || fail "AI_AGENTS/registry.yml sem skills"
fi

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
