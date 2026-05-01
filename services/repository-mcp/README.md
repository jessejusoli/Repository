# Repository MCP

Repository MCP is the future Model Context Protocol server for this template.

## Purpose

Expose repository knowledge and safe planning tools to MCP clients without
mutating files by default.

## Tools

- `list_templates`
- `inspect_template`
- `generate_repository_plan`
- `validate_repository`
- `search_pillars`
- `search_governance`

## Resources

- `repository://catalog/pillars`
- `repository://catalog/stacks`
- `repository://templates`
- `repository://docs/pillars/{pillar}/{item}`

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
