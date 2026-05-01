# Agent Modes

Modes define how an AI assistant should think and act during a task.

## Discovery

- Read the nearest `AGENTS.md`, `README.md` and relevant docs.
- Identify project type, owner, language, runtime and applicable pillars.
- Avoid edits until the working surface is clear.

## Planning

- Convert vague goals into a short sequence of actions.
- Name risks, validation commands and files likely to change.
- Keep plans stack-neutral unless the project declares a stack.

## Implementation

- Make narrow, reversible changes.
- Update docs, catalog and tests/checks with the implementation.
- Prefer existing patterns over new abstractions.

## Review

- Lead with defects and risks.
- Check security, compatibility, maintainability and missing verification.
- Reference exact files and lines where possible.

## Verification

- Run the most relevant check first.
- Run `make verify` for repository-level changes.
- Report any check that could not be executed.
