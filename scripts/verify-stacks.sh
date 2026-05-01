#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CATALOG="$ROOT_DIR/catalog/stacks.yml"
failures=0

info() {
  printf '[stacks] %s\n' "$1"
}

fail() {
  printf '[stacks] ERRO: %s\n' "$1" >&2
  failures=$((failures + 1))
}

info "validando catalogo de stacks"
[[ -f "$CATALOG" ]] || fail "arquivo ausente: catalog/stacks.yml"

if [[ -f "$CATALOG" ]]; then
  grep -q '^schema_version: 1$' "$CATALOG" || fail "schema_version ausente"
  stack_count="$(grep -c '^  - id:' "$CATALOG")"
  language_count="$(grep -c '^    language:' "$CATALOG")"
  runtime_count="$(grep -c '^    runtimes:' "$CATALOG")"
  package_count="$(grep -c '^    package_managers:' "$CATALOG")"
  build_count="$(grep -c '^      build:' "$CATALOG")"
  test_count="$(grep -c '^      test:' "$CATALOG")"
  lint_count="$(grep -c '^      lint:' "$CATALOG")"
  deploy_count="$(grep -c '^      deploy:' "$CATALOG")"

  [[ "$stack_count" -ge 8 ]] || fail "catalog/stacks.yml deve conter pelo menos 8 stacks"
  [[ "$language_count" -eq "$stack_count" ]] || fail "stack sem language"
  [[ "$runtime_count" -eq "$stack_count" ]] || fail "stack sem runtimes"
  [[ "$package_count" -eq "$stack_count" ]] || fail "stack sem package_managers"
  [[ "$build_count" -eq "$stack_count" ]] || fail "stack sem commands.build"
  [[ "$test_count" -eq "$stack_count" ]] || fail "stack sem commands.test"
  [[ "$lint_count" -eq "$stack_count" ]] || fail "stack sem commands.lint"
  [[ "$deploy_count" -eq "$stack_count" ]] || fail "stack sem commands.deploy"
fi

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
