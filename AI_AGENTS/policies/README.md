# Agent Policies

## General Guardrails

- Treat generated output as draft until reviewed.
- Do not expose secrets or private data to prompts, tools or logs.
- Prefer deterministic verification over subjective confidence.
- Keep human-readable documentation aligned with agent instructions.

## Repository Guardrails

- The 13-pillar model is mandatory for repository-level governance.
- `contracts/` contains templates and contracts, not production secrets.
- `AI_AGENTS/` describes agent behavior; it does not override `SECURITY.md`.
- Project-specific instructions may add nested `AGENTS.md` files.
