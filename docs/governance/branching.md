# Fluxo de Branches

## Estrategia

A estrategia recomendada e trunk-based development:

- `main` sempre deve estar integravel.
- Branches de trabalho devem viver pouco tempo.
- Pull requests devem ser pequenos e revisaveis.
- Releases devem sair de `main` ou de tags criadas a partir de `main`.

## Padrao de nomes

- `feat/<descricao>`
- `fix/<descricao>`
- `docs/<descricao>`
- `chore/<descricao>`
- `refactor/<descricao>`
- `release/<versao-ou-produto>`

## Protecao de `main`

Configure Rulesets ou Branch Protection no GitHub com:

- Pull request obrigatorio.
- Status checks obrigatorios.
- Revisao de CODEOWNERS para areas criticas.
- Historico linear quando fizer sentido para o time.
- Bloqueio de force push e delecao da branch.

## Hotfix

Hotfixes devem seguir o mesmo fluxo de revisao, com prioridade alta e escopo
minimo. Se for necessario publicar antes da documentacao completa, abra uma
issue de follow-up no mesmo dia.
