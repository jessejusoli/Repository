# Checklist de Novo Projeto

Use esta lista sempre que adicionar uma aplicacao, pacote ou servico.

## Antes de criar

- O objetivo do projeto esta claro.
- Nao existe projeto atual que resolva o mesmo problema.
- O owner tecnico foi definido.
- O modelo de release foi escolhido.

## Criacao

- Criar pasta em `apps/`, `packages/`, `services/`, `infra/`, `tooling/` ou
  `examples/`.
- Adicionar `README.md` usando `docs/templates/PROJECT.md`.
- Registrar em `catalog/projects.yml`.
- Registrar ou revisar ownership em `catalog/owners.yml`.
- Declarar pilares aplicaveis no README do projeto.
- Criar contratos em `contracts/` quando houver API, MCP, Postman ou RAG.
- Atualizar `.github/CODEOWNERS` quando necessario.

## Antes do primeiro PR

- Comandos locais documentados.
- Validacao minima disponivel.
- Riscos e dependencias descritos.
- Checklist universal revisado.
- `make verify` executado com sucesso.
