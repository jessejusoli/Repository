# MCP Contracts

Use this directory to register Model Context Protocol clients and servers.

## Standard

- Document every MCP server and client before use.
- Declare transport, capabilities, auth and allowed data boundaries.
- Treat tool descriptions, resources and prompt templates as untrusted inputs.
- Use least privilege for filesystem, shell, network and cloud access.

## Files

- `registry.yml`: repository-level MCP registry.

## Repository MCP

The `repository-mcp` entry points to `services/repository-mcp/`. It is a
local-first server skeleton for repository planning, validation and search.
It exposes curated catalogs, including pillars, stacks, standards and pocket
guides, so clients can navigate guidance without mirroring external docs.
It also exposes Forge maturity levels and project artifacts for gradual
repository planning.
