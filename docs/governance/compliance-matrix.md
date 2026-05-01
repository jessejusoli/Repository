# Compliance Matrix

This matrix maps repository controls to the 13 pillars. It is not a legal
certification; it is an engineering control map.

| Pillar | Repository control |
| --- | --- |
| Front-end | Project template requires UI, accessibility and validation notes. |
| Back-end | OpenAPI and Postman contract templates define API expectations. |
| Infrastructure | `infra/` is reserved for versioned infrastructure definitions. |
| DevOps | `ci.yaml`, `repository-health.yml` and `Makefile` define checks. |
| Security | `SECURITY.md`, CODEOWNERS and AI/MCP/RAG guardrails define baseline controls. |
| Quality Assurance | Verification scripts validate structure, contracts, pillars and agents. |
| Data | RAG profile requires corpus, retention, privacy and evaluation decisions. |
| Product/UX | Project proposals require objective, owner and expected impact. |
| Architecture | ADR, RFC and universal project model document structural decisions. |
| SRE | Release and readiness checklists require observability and rollback decisions. |
| IT Governance | Catalog files track projects, owners, pillars and accountability. |
| Developer Experience | `AGENTS.md`, `AI_AGENTS/` and `make verify` reduce onboarding friction. |
| Sustainability | Universal checklist requires resource and waste evaluation when applicable. |

## External Standards

Projects may map their own controls to frameworks such as ISO, SOC 2, COBIT,
ITIL, NIST, OWASP, WCAG or regulatory requirements. Add project-specific
mapping near the project and summarize it in `catalog/projects.yml`.
