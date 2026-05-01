# Repository MCP

Repository MCP is the future Model Context Protocol server for Repository Forge.

## Purpose

Expose repository knowledge and safe planning tools to MCP clients without
mutating files by default.

## Tools

- `list_templates`
- `list_maturity_levels`
- `list_project_artifacts`
- `inspect_template`
- `generate_repository_plan`
- `validate_repository`
- `search_pillars`
- `search_governance`

## Resources

- `repository://catalog/pillars`
- `repository://catalog/stacks`
- `repository://catalog/standards`
- `repository://catalog/project-lifecycle`
- `repository://catalog/project-artifacts`
- `repository://templates`
- `repository://docs/pillars/{pillar}/{item}`
- `repository://standards/{standard_id}`
- `repository://pillars/{pillar}/standards`
- `repository://forge/maturity/{level}`

## Commands

```bash
npm install
npm run build
npm test
npm run mcp:inspect
```

## Boundary

This package is isolated from the repository root. Root verification must not
require installing Node dependencies.
