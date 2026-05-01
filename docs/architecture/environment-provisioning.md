# Environment Provisioning

Repository provides safe provisioning blueprints, not production deployments.

## Environment Catalog

`catalog/environments.yml` defines standard environment names and controls:

- local
- dev
- staging
- prod
- edge
- mobile
- embedded

## Docker Compose

`infra/compose/` contains a disabled-by-default Compose blueprint. Projects may
copy or extend it after defining image, ports, secrets and owner.

## Kubernetes

`infra/kubernetes/` contains Kustomize resources for namespace, service account,
config, resource quota and network policy.

## Rule

No project should deploy before owner, secrets, rollback, monitoring and
environment boundaries are documented.
