# API, MCP And RAG Lifecycle

API, MCP and RAG artifacts should start as contracts and evolve into executable
systems only when ownership and validation are clear.

## API

- Define HTTP APIs in `contracts/openapi/`.
- Keep examples and smoke flows in `contracts/postman/`.
- Generate Swagger UI or equivalent documentation from OpenAPI when a service exists.

## MCP

- Register servers and clients in `contracts/mcp/registry.yml`.
- Document tools, resources, prompts, transport, auth and data boundaries.
- Validate inputs, sanitize outputs and audit tool calls.

## RAG

- Define corpus and safety boundaries in `contracts/rag/`.
- Store generated indexes outside Git, for example `.rag/`.
- Require citations and groundedness evaluation for user-facing answers.

## Repository Forge

The future `repository-mcp` service and `repository-forge` CLI will use these
contracts to generate repository plans, inspect templates and validate existing
repositories.
