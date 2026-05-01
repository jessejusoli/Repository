# Secrets Management

## Objetivo

Orientar quando e como aplicar `secrets-management` sem copiar a documentacao oficial para dentro do Repository.

## Quando Aplicar

Aplica-se a: projects-with-secrets.

## Criterios De Adocao

- Secrets never live in Git.
- Secret ownership, scope and rotation are documented.

## Artefatos Esperados

- `SECURITY.md`
- `infra/kubernetes/policies/secrets.md`

## Links Oficiais

- [Documentacao oficial](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions)

## Pilares Relacionados

- `security`
- `infrastructure`
- `devops`
- `sre`

## Blueprints Relacionados

- `api-service`
- `background-worker`
- `data-pipeline`
- `rag-app`
- `mcp-server`

## Como Usar No Repository

- Consulte este pocket guide para decidir aplicabilidade.
- Registre evidencia no README do projeto, catalogo, contrato ou checklist correspondente.
- Use o link oficial para detalhes completos, exemplos extensos e mudancas de versao.
