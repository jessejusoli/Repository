# Guia de Contribuicao

Obrigado por contribuir com o Repository.

## Fluxo recomendado

1. Abra ou vincule uma issue quando a mudanca nao for trivial.
2. Crie uma branch curta a partir de `main`.
3. Mantenha o escopo pequeno e facil de revisar.
4. Atualize documentacao, catalogo e templates quando o comportamento mudar.
5. Rode `make verify`.
6. Abra um pull request usando o template padrao.

## Padrao de branches

- `feat/<descricao>` para novas capacidades.
- `fix/<descricao>` para correcoes.
- `docs/<descricao>` para documentacao.
- `chore/<descricao>` para manutencao.

## Commits

Use Conventional Commits sempre que possivel:

```text
feat(scope): adiciona novo projeto ao catalogo
fix(ci): corrige validacao de documentacao
docs(readme): atualiza guia inicial
```

## Criterios de aceite

- A mudanca tem owner claro.
- O comportamento esperado esta documentado.
- O CI passa.
- Riscos, migracoes e impactos foram explicados no pull request.
