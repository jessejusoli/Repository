# Gestao de Releases

## Modelos suportados

O monorepo pode operar com dois modelos:

- Release independente: cada app, pacote ou servico versiona separadamente.
- Release coordenada: um conjunto de projetos publica junto como produto.

Escolha o modelo por projeto em `catalog/projects.yml`.

## Versionamento

Use SemVer para artefatos consumidos por outros projetos:

- `MAJOR`: quebra contrato.
- `MINOR`: adiciona capacidade compativel.
- `PATCH`: corrige comportamento sem alterar contrato.

## Tags

Padroes recomendados:

- `package-name@1.2.3` para releases independentes.
- `product-name/2026.05.0` para releases coordenadas.

## Changelog

Cada projeto publicado deve manter changelog proprio ou contribuir para o
`CHANGELOG.md` raiz quando o repositorio inteiro for o artefato.

## Criterios antes de publicar

- CI verde.
- Revisao aprovada.
- Impacto documentado.
- Plano de rollback conhecido.
- Segredos e configuracoes conferidos.
