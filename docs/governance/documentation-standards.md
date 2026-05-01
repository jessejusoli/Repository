# Documentation Standards

Documentation is part of the product surface of this repository.

## Required Documents

- `README.md` for orientation.
- `AGENTS.md` for coding agents.
- Project README for every project directory.
- ADRs for important architectural decisions.
- RFCs for broad or risky changes.
- API contracts for services and integrations.

## Diagrams

Prefer Mermaid or text-based diagrams that can be reviewed in Git.

Store reusable diagrams in `docs/diagrams/` and reference them from architecture
documents.

## Badges

Badges should communicate operational state, not decoration. Recommended root
badges:

- CI.
- Repository Health.
- Release status when releases exist.
- Security scan when configured.

## Editing

- Use Markdown for human-readable docs.
- Keep one H1 per Markdown file.
- Avoid secrets, private URLs and credentials.
- Keep examples clearly marked as examples or templates.
- Update docs in the same change that updates behavior.
