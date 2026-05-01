# CI/CD

This repository uses language-neutral CI at the root. Project-specific CI can be
added later under the same workflow strategy.

## CI

The main workflow is `.github/workflows/ci.yaml`.

It validates:

- Repository structure.
- 13-pillar self-assessment.
- API, Postman, MCP and RAG contracts.
- Agent instructions and registry.

## CD

`.github/workflows/cd.yaml` is a manual delivery-readiness workflow. It does not
deploy by default because this template is language-neutral and
environment-neutral.

When adding delivery or deployment:

- Use GitHub environments for approval boundaries.
- Use least-privilege tokens and OIDC where supported.
- Define rollback before production deploys.
- Keep project-specific deploy logic close to the project.
- Document release policy in `catalog/projects.yml`.

## Naming

- `ci.yaml`: root continuous integration.
- `cd.yaml`: manual delivery readiness and future deployment entry point.
- `repository-health.yml`: template health gate.
- Future project workflows should include the project id in the workflow name.
