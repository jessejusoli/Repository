# Politica de Seguranca

## Versoes suportadas

Enquanto este repositorio for usado como template, a branch `main` representa a
versao suportada.

## Como reportar vulnerabilidades

Nao abra issues publicas para vulnerabilidades sensiveis. Use o canal privado
da organizacao ou GitHub Security Advisories quando habilitado.

Inclua no relato:

- Descricao do problema.
- Passos de reproducao.
- Impacto esperado.
- Evidencias tecnicas.
- Sugestao de mitigacao, se houver.

## Praticas obrigatorias

- Segredos nunca devem ser commitados.
- Dependencias devem ser atualizadas por automacao ou revisao explicita.
- Workflows devem usar permissoes minimas.
- Mudancas em `.github/`, `infra/`, `scripts/` e `tooling/` exigem revisao
  cuidadosa de ownership.
