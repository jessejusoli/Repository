# Repository Forge

Repository Forge is the CLI for turning this repository knowledge base into
gradual repository plans.

## Purpose

- Inspect repository blueprints.
- Generate non-mutating repository plans in Markdown and JSON.
- Recommend artifacts by maturity level from M0 to M5.
- Validate existing repositories against catalogs and pillar docs.
- Build local RAG indexes outside Git.

## Commands

```bash
npm install
npm run build
npm test
npm run forge:validate
npm run rag:index
```

Planned CLI shape:

```bash
repository-forge plan example-api api-service node-typescript M2 both
```

## Boundary

This package is isolated under `tooling/` and does not make the repository root
a Node project.

Forge does not scaffold or write generated repositories in this phase. It plans
the right baseline first.
