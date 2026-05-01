#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
failures=0

info() {
  printf '[infra] %s\n' "$1"
}

fail() {
  printf '[infra] ERRO: %s\n' "$1" >&2
  failures=$((failures + 1))
}

require_file() {
  local path="$1"
  [[ -f "$ROOT_DIR/$path" ]] || fail "arquivo obrigatorio ausente: $path"
}

info "validando Docker Compose e Kubernetes"
require_file "infra/README.md"
require_file "infra/compose/README.md"
require_file "infra/compose/compose.yaml"
require_file "infra/compose/.env.example"
require_file "infra/kubernetes/README.md"
require_file "infra/kubernetes/base/kustomization.yaml"
require_file "infra/kubernetes/base/namespace.yaml"
require_file "infra/kubernetes/base/service-account.yaml"
require_file "infra/kubernetes/base/configmap.yaml"
require_file "infra/kubernetes/base/resource-quota.yaml"
require_file "infra/kubernetes/base/network-policy.yaml"
require_file "infra/kubernetes/overlays/local/kustomization.yaml"
require_file "infra/kubernetes/policies/README.md"
require_file "infra/kubernetes/policies/secrets.md"
require_file "infra/kubernetes/policies/environments.md"

grep -q '^services:' "$ROOT_DIR/infra/compose/compose.yaml" || fail "compose sem services"
grep -q 'profiles:' "$ROOT_DIR/infra/compose/compose.yaml" || fail "compose deve usar profile para blueprint"
grep -q 'read_only: true' "$ROOT_DIR/infra/compose/compose.yaml" || fail "compose deve usar read_only"
grep -q '^kind: Kustomization$' "$ROOT_DIR/infra/kubernetes/base/kustomization.yaml" || fail "base sem Kustomization"
grep -q 'network-policy.yaml' "$ROOT_DIR/infra/kubernetes/base/kustomization.yaml" || fail "kustomization sem network policy"
grep -q '^kind: NetworkPolicy$' "$ROOT_DIR/infra/kubernetes/base/network-policy.yaml" || fail "network-policy invalida"
grep -q '^kind: ResourceQuota$' "$ROOT_DIR/infra/kubernetes/base/resource-quota.yaml" || fail "resource-quota invalida"

if [[ "$failures" -gt 0 ]]; then
  fail "validacao concluida com $failures problema(s)"
  exit 1
fi

info "validacao concluida com sucesso"
