# OpenAPI Contracts

Use this directory for HTTP API descriptions.

## Standard

- Prefer OpenAPI `3.2.0` for new contracts when tooling supports it.
- Use OpenAPI `3.1.x` when downstream tooling does not yet support `3.2.0`.
- Every API must declare `info`, `paths`, auth expectations and error shapes.
- Swagger UI or equivalent documentation should be generated from the contract.

## Files

- `repository.template.openapi.yaml`: minimal template for new HTTP APIs.
- `repository.forge.openapi.yaml`: future Repository Forge API contract.
