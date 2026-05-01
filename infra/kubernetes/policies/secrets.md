# Secrets Policy

Secrets must not be committed to this repository.

## Baseline

- Use GitHub environments, external secret stores or cluster-native secret
  integrations.
- Document secret owners and rotation periods.
- Never place real values in Kustomize, Compose or examples.
