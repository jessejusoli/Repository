# Repository Forge

Repository Forge transforma a knowledge base deste repositorio em planos graduais para novos projetos.

Ele nao copia tudo para todo projeto. Ele cruza blueprint, stack, ambiente, standards, pilares e maturidade para recomendar o que deve nascer agora e o que pode evoluir depois.

## Camadas

- Core interno: arquivos que governam o proprio Repository.
- Knowledge Base: catalogos, pilares, standards, blueprints e templates navegaveis.
- Forge: CLI e MCP para gerar planos em Markdown e JSON sem mutar repositorios nesta fase.

## Maturidade

- M0 Concept: problema, publico, owner, escopo, riscos e decisao de seguir.
- M1 Repository Baseline: README, LICENSE decision, AGENTS, CODEOWNERS, CHANGELOG, CI health e backlog inicial.
- M2 MVP Ready: setup, exemplo de uso, backlog priorizado, milestones, criterios de MVP e testes minimos.
- M3 Beta Validation: QA, seguranca, release notes, contratos e observabilidade inicial.
- M4 Production Ready: deploy, secrets, rulesets, SLOs, incidentes, rollback, backups e supply chain.
- M5 Scale Governance: compliance, metricas, custo, sustentabilidade, multi-ambiente e melhoria continua.

## Fontes

- `catalog/project-lifecycle.yml`: niveis M0-M5, criterios, evidencias e gates.
- `catalog/project-artifacts.yml`: artefatos, templates, standards e pilares relacionados.
- `catalog/repository-blueprints.yml`: tipos de projeto e artefatos aplicaveis.
- `tooling/repository-forge/`: CLI local para planejamento.
- `services/repository-mcp/`: recursos e ferramentas MCP para clientes compativeis.

## Saidas

- Markdown para humanos revisarem escopo, backlog, roadmap e proximas acoes.
- JSON para automacao, MCP, RAG e validacoes futuras.

## Regra

Nesta fase, o Forge gera planos e matrizes de decisao. Scaffold e escrita de arquivos ficam para uma fase posterior.
