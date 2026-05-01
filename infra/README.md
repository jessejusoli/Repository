# Infrastructure

Infrastructure blueprints live here. They are safe starting points, not
production deployments.

## Areas

- `compose/`: Docker Compose blueprint for local multi-container development.
- `kubernetes/`: Kustomize blueprint for Kubernetes resources and policies.

## Rule

Projects may copy or extend these blueprints only after they declare owner,
environment, secrets model and rollback expectations.
