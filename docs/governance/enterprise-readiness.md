# Enterprise Readiness

Enterprise readiness means a project can be understood, reviewed, secured,
operated and evolved by more than one person or team.

## Baseline

- Clear owner in `catalog/owners.yml`.
- Project registration in `catalog/projects.yml`.
- Applicable pillars selected from `catalog/pillars.yml`.
- Item-level evidence from `docs/pillars/`.
- Stack and environment declared when implementation exists.
- CI checks required before merge.
- Secrets outside Git.
- Release and rollback expectations documented.

## Repository Controls

- `make verify-all` is the root confidence command.
- `.github/CODEOWNERS` defines review boundaries.
- `.github/workflows/ci.yaml` separates repository, pillars, contracts, infra and agents.
- `contracts/` keeps API, MCP and RAG interfaces versioned.
- `infra/` keeps deployment blueprints separate from application code.

## Graduation

A project may move from template to production only when its owner can point to
evidence for security, quality, release, observability and rollback.
