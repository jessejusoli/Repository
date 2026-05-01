# Docker Compose Specification

## Objetivo

Orientar quando e como aplicar `docker-compose` sem copiar a documentacao oficial para dentro do Repository.

## Quando Aplicar

Aplica-se a: local-development, multi-container-projects.

## Criterios De Adocao

- Compose files are safe templates with no real secrets.
- Optional services use profiles when appropriate.

## Artefatos Esperados

- `infra/compose/compose.yaml`

## Links Oficiais

- [Documentacao oficial](https://docs.docker.com/reference/compose-file/)

## Pilares Relacionados

- `infrastructure`
- `devops`
- `developer_experience`
- `sustainability`

## Blueprints Relacionados

- `web-app`
- `api-service`
- `background-worker`
- `data-pipeline`
- `rag-app`
- `mcp-server`

## Como Usar No Repository

- Consulte este pocket guide para decidir aplicabilidade.
- Registre evidencia no README do projeto, catalogo, contrato ou checklist correspondente.
- Use o link oficial para detalhes completos, exemplos extensos e mudancas de versao.
