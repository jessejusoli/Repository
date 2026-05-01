#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

failures=0

info() {
  printf '[pillars] %s\n' "$1"
}

fail() {
  printf '[pillars] ERRO: %s\n' "$1" >&2
  failures=$((failures + 1))
}

PILLARS_FILE="$ROOT_DIR/catalog/pillars.yml"
ASSESSMENT_FILE="$ROOT_DIR/catalog/repository-self-assessment.yml"

info "validando catalogo de pilares"
[[ -f "$PILLARS_FILE" ]] || fail "arquivo ausente: catalog/pillars.yml"
[[ -f "$ASSESSMENT_FILE" ]] || fail "arquivo ausente: catalog/repository-self-assessment.yml"

if [[ -f "$PILLARS_FILE" ]]; then
  pillar_count="$(grep -c '^  - id:' "$PILLARS_FILE")"
  [[ "$pillar_count" -eq 13 ]] || fail "catalog/pillars.yml deve conter 13 pilares; encontrado: $pillar_count"
fi

if [[ -f "$PILLARS_FILE" && -f "$ASSESSMENT_FILE" ]]; then
  assessment_count="$(grep -c '^  - pillar:' "$ASSESSMENT_FILE")"
  [[ "$assessment_count" -eq 13 ]] || fail "repository-self-assessment.yml deve conter 13 coberturas; encontrado: $assessment_count"

  while IFS= read -r pillar_id; do
    if ! grep -q "pillar: $pillar_id$" "$ASSESSMENT_FILE"; then
      fail "pilar sem autoavaliacao: $pillar_id"
    fi
  done < <(sed -n 's/^  - id: //p' "$PILLARS_FILE")
fi

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
