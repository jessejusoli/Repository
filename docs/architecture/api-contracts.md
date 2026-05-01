# API Contracts

API contracts make integration work language-neutral. The contract should be
understandable before the implementation stack is selected.

## OpenAPI

Use `contracts/openapi/` for HTTP APIs.

Required baseline:

- `openapi` version.
- `info.title` and `info.version`.
- `paths`.
- Authentication and authorization expectations when applicable.
- Error response shape.

Swagger UI or equivalent documentation should be generated from the OpenAPI
description for human exploration.

## Postman

Use `contracts/postman/` for executable API examples, smoke flows and manual
verification. Collections must not contain real secrets or private environment
values.

## Compatibility

If tooling does not support the newest OpenAPI version yet, document the chosen
version and the reason in the project README or an ADR.
