# Repository Forge

Repository Forge is the future CLI for generating and validating repositories
from this template.

## Purpose

- Inspect repository blueprints.
- Generate non-mutating repository plans.
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

## Boundary

This package is isolated under `tooling/` and does not make the repository root
a Node project.
