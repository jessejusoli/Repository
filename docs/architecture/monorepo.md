# Arquitetura do Monorepo

## Principios

- O repositorio e organizado por tipo de responsabilidade, nao por time.
- Cada projeto deve ter dono, caminho, ciclo de vida e politica de release.
- Codigo compartilhado fica em `packages/`, nao copiado entre projetos.
- Automacoes reutilizaveis ficam em `tooling/` ou `scripts/`.
- Infraestrutura versionada fica em `infra/`.

## Diretorios padrao

| Diretorio | Uso |
| --- | --- |
| `apps/` | Produtos finais executados por usuarios ou operadores. |
| `packages/` | Bibliotecas, SDKs, design systems e modulos compartilhados. |
| `services/` | APIs, workers, consumers, jobs e servicos backend. |
| `infra/` | Terraform, Kubernetes, Helm, Docker Compose e ambientes. |
| `tooling/` | Geradores, CLIs, presets e utilitarios internos. |
| `examples/` | Exemplos de uso, sandboxes e referencias executaveis. |
| `catalog/` | Inventario de projetos e ownership. |
| `contracts/` | Contratos OpenAPI, Postman, MCP e RAG. |
| `AI_AGENTS/` | Modos, subagentes, skills e politicas para IA. |

## Contrato minimo de cada projeto

Cada novo projeto deve conter:

- `README.md` com objetivo, comandos e owner.
- Arquivo de configuracao da stack quando aplicavel.
- Testes ou criterio explicito de validacao.
- Registro em `catalog/projects.yml`.
- Owner em `catalog/owners.yml` ou `.github/CODEOWNERS`.
- Pilares aplicaveis declarados no README do projeto.
- Contratos em `contracts/` quando expuser APIs, MCP ou RAG.

## Quando criar um pacote compartilhado

Crie um pacote em `packages/` quando:

- Dois ou mais projetos precisam da mesma regra ou API.
- Existe contrato estavel entre consumidores.
- A duplicacao comeca a gerar risco de divergencia.

Evite pacotes compartilhados para codigo experimental ou sem consumidor real.

## Diagrama de contexto

O diagrama de alto nivel do template fica em
`docs/diagrams/repository-context.mmd`.
