# Subagents

Subagents are bounded roles for parallel or specialized work. They are a
coordination model, not a separate source of truth.

## Standard Roles

| Role | Responsibility |
| --- | --- |
| Architecture | ADRs, diagrams, trade-offs and pillar coverage. |
| Security | Secrets, auth, permissions, threat model and supply chain. |
| DevOps | CI/CD, environments, releases, rollback and DORA signals. |
| Documentation | READMEs, templates, diagrams, badges and editing standards. |
| AI Systems | MCP, RAG, prompts, tools, evaluation and safety controls. |

## Rules

- Give each subagent a clear file scope.
- Avoid overlapping writes.
- Require changed files and validation notes in the result.
- Integrate results through normal review and repository verification.
