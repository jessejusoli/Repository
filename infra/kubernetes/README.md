# Kubernetes Blueprint

This directory contains Kustomize resources that model safe defaults for future
projects.

## Layout

- `base/`: namespace, service account, config and baseline policy resources.
- `overlays/local/`: local overlay for validation and experimentation.
- `policies/`: explanatory policy documents and reusable policy examples.

## Usage

```bash
kubectl kustomize infra/kubernetes/base
kubectl kustomize infra/kubernetes/overlays/local
```

Do not apply these resources to a real cluster without replacing names, quotas,
labels and ownership metadata.
