# Documentacao

Esta pasta concentra a memoria operacional do repositorio.

## Areas

- `architecture/`: desenho do monorepo e decisoes tecnicas estruturais.
- `governance/`: regras de branch, revisao, release e seguranca.
- `automation/`: workflows, bots e rotinas de manutencao.
- `checklists/`: listas de verificacao para operacoes recorrentes.
- `templates/`: modelos para documentos criados durante a evolucao do repo.
- `diagrams/`: diagramas textuais versionaveis.
- `pillars/`: guias operacionais dos 13 pilares e seus 260 itens.
- `standards/`: pocket guides, criterios de adocao e links oficiais.

## Pilares universais

O arquivo raiz `references.md` contem a versao extensa dos 13 pilares. O resumo
operacional esta em `docs/architecture/universal-project-model.md`, e o catalogo
estruturado fica em `catalog/pillars.yml`.

Os guias item a item ficam em `docs/pillars/`, com rastreabilidade em
`catalog/pillar-items.yml`.

## Standards e pocket guides

`catalog/standards.yml` e a fonte estruturada para standards formais e praticas
uteis. `docs/standards/` contem pocket guides curtos: objetivo, quando aplicar,
criterios, artefatos esperados, links oficiais e relacoes com pilares e
blueprints.

O repositorio nao espelha documentacao oficial. Ele aponta para a fonte
confiavel e guarda apenas a orientacao operacional necessaria para novos
projetos nascerem bem organizados.

## Contratos e IA

Contratos de API, Postman, MCP e RAG vivem em `contracts/`. Instrucoes para
agentes de IA ficam em `AGENTS.md` e `AI_AGENTS/`.

## Fundacao Universal

- `docs/architecture/stack-catalog.md`: como usar `catalog/stacks.yml`.
- `docs/architecture/environment-provisioning.md`: como usar Compose e Kustomize.
- `docs/architecture/api-mcp-rag-lifecycle.md`: ciclo de vida de API, MCP e RAG.
- `docs/standards/README.md`: indice navegavel de standards e pocket guides.
- `docs/governance/enterprise-readiness.md`: criterios de prontidao enterprise.
- `docs/governance/supply-chain-security-baseline.md`: baseline de supply chain.

## Regra pratica

Se uma decisao afeta mais de um projeto, time ou pipeline, ela deve estar
documentada aqui antes de virar padrao.
