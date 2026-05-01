# Modelo de Seguranca

## Principios

- Menor privilegio por padrao.
- Segredos fora do repositorio.
- Automacoes com permissoes explicitas.
- Owners claros para areas sensiveis.
- Atualizacoes de dependencias com rastreabilidade.

## Areas sensiveis

- `.github/workflows/`
- `.github/dependabot.yml`
- `.github/CODEOWNERS`
- `infra/`
- `scripts/`
- `tooling/`

## Controles recomendados no GitHub

- Rulesets para proteger `main`.
- CODEOWNERS com revisao obrigatoria.
- Dependabot para GitHub Actions e manifests de dependencias.
- Secret scanning e push protection quando disponiveis.
- Code scanning para stacks suportadas.

## Segredos

Segredos devem viver em GitHub Secrets, environments ou cofre externo. Arquivos
`.env` reais ficam ignorados; apenas `.env.example` pode ser versionado.
