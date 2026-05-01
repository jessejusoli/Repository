# Revisao de Codigo

## Objetivo

Revisao existe para reduzir risco, compartilhar contexto e preservar a saude do
repositorio.

## Checklist do autor

- O escopo esta claro.
- O PR explica motivacao, solucao e riscos.
- Documentacao e catalogo foram atualizados quando necessario.
- `make verify` passou localmente.
- Mudancas sensiveis tem evidencia de teste ou validacao manual.

## Checklist do reviewer

- O comportamento proposto resolve o problema declarado.
- O impacto em outros projetos foi considerado.
- A mudanca respeita ownership e padroes existentes.
- A automacao cobre o risco principal.
- Nao ha segredos, credenciais ou dados sensiveis.

## Areas criticas

Mudancas nestas areas merecem revisao extra:

- `.github/`
- `infra/`
- `scripts/`
- `tooling/`
- Arquivos de autenticacao, autorizacao ou deploy.
