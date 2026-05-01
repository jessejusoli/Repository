# MCP Guidance

Model Context Protocol integrations must be treated as privileged integration
points.

## Required Decisions

- Host and client that will connect to the server.
- Transport: STDIO, streamable HTTP or another supported transport.
- Server capabilities: tools, resources and prompts.
- Authentication and authorization model.
- Allowed commands, endpoints and data sources.
- Logging and audit boundaries.

## Safety Baseline

- Default deny for tools and external commands.
- No unreviewed shell execution from model-controlled input.
- No secrets in prompts, logs or tool descriptions.
- Use explicit allowlists for filesystem, network and cloud actions.
- Document every server in `contracts/mcp/registry.yml`.
