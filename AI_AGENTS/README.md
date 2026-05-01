# AI Agents

This directory complements root `AGENTS.md` with detailed operating models for
AI-assisted development.

## Layout

- `registry.yml`: structured inventory of modes, subagents and skills.
- `modes/`: how an agent should behave in each work mode.
- `subagents/`: bounded responsibilities for delegated agents.
- `skills/`: reusable capabilities and when to use them.
- `mcp/`: MCP client/server patterns and safety requirements.
- `rag/`: retrieval-augmented generation patterns.
- `policies/`: security, privacy and quality guardrails.

## Rule

Agent instructions must help automation without hiding decisions from humans.
Anything that changes governance, security or release behavior must also be
documented under `docs/`.
