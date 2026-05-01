# Automacoes GitHub

## Workflows

`CI` executa a suite principal de verificacoes em push para `main`, pull
requests e execucao manual.

`CD Readiness` executa verificacao manual de prontidao de entrega antes que um
projeto adicione passos reais de deploy.

`Repository Health` executa `make verify` como gate de saude do template.

O workflow usa permissoes minimas:

```yaml
permissions:
  contents: read
```

## Dependabot

`.github/dependabot.yml` atualiza GitHub Actions semanalmente e agrupa updates
relacionados para reduzir ruido.

Quando forem adicionadas stacks como npm, Go, Python, Java ou Terraform, inclua
novos blocos de Dependabot apontando para os manifests reais.

## CODEOWNERS

`.github/CODEOWNERS` define quem deve revisar cada area. Antes de ativar a
exigencia de revisao por owner, substitua os placeholders por usuarios ou times
existentes no GitHub.

## Rulesets

Rulesets devem ser configurados na interface ou API do GitHub. Recomendacao
inicial:

- Bloquear delecao e force push em `main`.
- Exigir pull request.
- Exigir status check `Repository Health / validate`.
- Exigir status checks do workflow `CI`.
- Exigir revisao de CODEOWNERS para areas criticas.
