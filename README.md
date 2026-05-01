# Repository

[![CI](https://github.com/jessejusoli/Repository/actions/workflows/ci.yaml/badge.svg)](https://github.com/jessejusoli/Repository/actions/workflows/ci.yaml)
[![CD Readiness](https://github.com/jessejusoli/Repository/actions/workflows/cd.yaml/badge.svg)](https://github.com/jessejusoli/Repository/actions/workflows/cd.yaml)
[![Repository Health](https://github.com/jessejusoli/Repository/actions/workflows/repository-health.yml/badge.svg)](https://github.com/jessejusoli/Repository/actions/workflows/repository-health.yml)

Repositorio master para criar, organizar, automatizar e governar projetos em
formato monorepo.

Este projeto nasce como um template operacional: ele nao e uma aplicacao, e sim
uma base de trabalho para novos repositorios que precisam crescer com clareza,
padrao de qualidade, automacao e rastreabilidade.

## Sumario

- [Objetivos](#objetivos)
- [Capacidades](#capacidades)
- [Estrutura](#estrutura)
- [Quickstart](#quickstart)
- [Automacoes incluidas](#automacoes-incluidas)
- [Documentacao principal](#documentacao-principal)
- [Estado do projeto](#estado-do-projeto)

## Objetivos

- Padronizar a estrutura de projetos monorepo.
- Separar aplicacoes, bibliotecas, servicos, infraestrutura e tooling.
- Documentar decisoes, ownership, releases, seguranca e fluxo de contribuicao.
- Usar pilares universais para cobrir qualquer linguagem, stack ou ambiente.
- Curar standards, praticas e tecnicas sem espelhar documentacao oficial.
- Automatizar verificacoes basicas desde o primeiro pull request.
- Servir como fonte de referencia para novos repositorios derivados.

## Capacidades

| Area | Status | Fonte |
| --- | --- | --- |
| 13 pilares universais | Aplicado | `docs/pillars/` e `catalog/pillar-items.yml` |
| Standards e pocket guides | Aplicado | `docs/standards/` e `catalog/standards.yml` |
| Stacks e linguagens | Preparado | `catalog/stacks.yml` |
| Ambientes | Preparado | `catalog/environments.yml` |
| Blueprints de projeto | Preparado | `catalog/repository-blueprints.yml` |
| Docker Compose | Blueprint seguro | `infra/compose/` |
| Kubernetes/Kustomize | Blueprint seguro | `infra/kubernetes/` |
| OpenAPI e Postman | Contratado | `contracts/openapi/` e `contracts/postman/` |
| MCP Server/Client | Roadmap com contrato | `contracts/mcp/registry.yml` |
| RAG | Perfil versionado | `contracts/rag/repository.rag-profile.yml` |
| Agentes de IA | Orientado | `AGENTS.md` e `AI_AGENTS/` |

## Estrutura

```text
.
|-- apps/                 # Aplicacoes finais: web, mobile, desktop, cli.
|-- packages/             # Bibliotecas compartilhadas e SDKs internos.
|-- services/             # APIs, workers, jobs e servicos independentes.
|-- infra/                # IaC, ambientes, manifests e configuracoes cloud.
|-- tooling/              # Scripts, CLIs, generators e utilitarios internos.
|-- examples/             # Exemplos executaveis ou projetos demonstrativos.
|-- catalog/              # Registro de projetos, owners e metadados.
|-- contracts/            # Contratos OpenAPI, Postman, MCP e RAG.
|-- AI_AGENTS/            # Modos, subagentes, skills e politicas para IA.
|-- docs/                 # Arquitetura, governanca, automacao e templates.
|   |-- pillars/          # 13 pilares e 260 guias operacionais item a item.
|   `-- standards/        # Pocket guides e links oficiais de standards.
|-- infra/compose/        # Docker Compose blueprint.
|-- infra/kubernetes/     # Kubernetes/Kustomize blueprint.
|-- services/             # Servicos futuros, incluindo MCP.
|-- tooling/              # CLIs futuros, incluindo Repository Forge.
|-- scripts/              # Automacoes locais e scripts usados pelo CI.
|-- AGENTS.md             # Instrucoes padrao para agentes de codigo.
`-- .github/              # Workflows, templates, CODEOWNERS e Dependabot.
```

## Quickstart

```bash
make verify-all
```

Para validar areas especificas:

```bash
make verify-stacks
make verify-blueprints
make verify-standards
make verify-infra
make verify-api-contracts
make verify-rag-profile
```

## Como usar este template

1. Crie um novo repositorio a partir desta base.
2. Atualize `.github/CODEOWNERS` com usuarios ou times reais.
3. Registre cada novo projeto em `catalog/projects.yml`.
4. Defina o owner tecnico em `catalog/owners.yml`.
5. Marque os pilares aplicaveis usando `catalog/pillars.yml`.
6. Copie `docs/templates/PROJECT.md` para a pasta do novo projeto.
7. Rode `make verify` antes de abrir pull requests.

## Modelo de trabalho

- Branch principal: `main`.
- Estrategia recomendada: trunk-based development com pull requests pequenos.
- Commits: Conventional Commits sempre que possivel.
- Revisao: pelo menos um reviewer e, em areas criticas, owner obrigatorio.
- Releases: independentes por projeto ou agrupadas por produto, conforme
  `docs/governance/release-management.md`.

## Automacoes incluidas

- `Repository Health`: valida a estrutura minima do template em cada PR.
- `CI`: consolida verificacoes de repositorio, pilares, contratos e agentes.
- `CD Readiness`: valida prontidao de entrega antes de qualquer deploy real.
- `Dependabot`: mantem GitHub Actions atualizadas semanalmente.
- Templates de issue e pull request para reduzir ambiguidade.
- CODEOWNERS para revisao baseada em ownership.

## Primeiros comandos

```bash
make verify
```

Se `make` nao estiver disponivel:

```bash
bash scripts/verify-repository.sh
```

## Documentacao principal

- [Arquitetura do monorepo](docs/architecture/monorepo.md)
- [Modelo universal de projetos](docs/architecture/universal-project-model.md)
- [Pilares operacionais](docs/pillars/README.md)
- [Standards e pocket guides](docs/standards/README.md)
- [Contratos de API e integracao](docs/architecture/api-contracts.md)
- [Sistemas de IA, MCP e RAG](docs/architecture/ai-systems.md)
- [CI/CD](docs/automation/ci-cd.md)
- [Agentes de IA](docs/automation/ai-agents.md)
- [Enterprise readiness](docs/governance/enterprise-readiness.md)
- [Supply chain/security baseline](docs/governance/supply-chain-security-baseline.md)
- [Stack catalog](docs/architecture/stack-catalog.md)
- [Environment provisioning](docs/architecture/environment-provisioning.md)
- [API/MCP/RAG lifecycle](docs/architecture/api-mcp-rag-lifecycle.md)
- [Fluxo de branches](docs/governance/branching.md)
- [Revisao de codigo](docs/governance/code-review.md)
- [Gestao de releases](docs/governance/release-management.md)
- [Modelo de seguranca](docs/governance/security-model.md)
- [Padroes de documentacao](docs/governance/documentation-standards.md)
- [Matriz de compliance](docs/governance/compliance-matrix.md)
- [Automacoes GitHub](docs/automation/github.md)
- [Checklist de novo projeto](docs/checklists/new-project.md)
- [Checklist universal de cobertura](docs/checklists/universal-project-readiness.md)

## Estado do projeto

Este repositorio esta em modo `template`. Antes de usar em producao, configure:

- Owners reais.
- Politicas de Rulesets ou Branch Protection no GitHub.
- Segredos e environments de deploy.
- Licenca aplicavel ao seu contexto.
- Ferramentas especificas da stack adotada.
