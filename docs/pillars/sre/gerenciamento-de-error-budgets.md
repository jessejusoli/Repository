# Gerenciamento de Error Budgets

## Pilar

SRE

## Objetivo

Alocacao de "budgets" para downtime, balanceando inovacao e estabilidade. Este item garante que a decisao seja visivel, revisavel e aplicavel em qualquer linguagem, stack ou ambiente.

## Quando Aplicar

Obrigatorio quando o projeto declarar o pilar SRE e depender deste comportamento para entregar valor, operar com seguranca ou reduzir risco.
Recomendado quando o item ainda estiver emergindo, mas ja afetar planejamento, qualidade, entrega ou manutencao.
Nao aplicavel apenas quando a justificativa estiver registrada no README do projeto, ADR, RFC ou checklist universal.

## Como Seguir

1. Declare a aplicabilidade no README do projeto e no checklist universal.
2. Identifique decisoes, responsaveis, entradas, saidas e riscos ligados ao item.
3. Escolha evidencias proporcionais ao risco: documento, contrato, teste, automacao, runbook, diagrama ou metrica.
4. Integre a evidencia ao fluxo de pull request, CI/CD, release ou operacao quando fizer sentido.
5. Revise o item sempre que o projeto mudar de escopo, ambiente, usuario, dado, dependencia ou criticidade.

## Evidencias Minimas

- Referencia no README do projeto ou em `catalog/projects.yml`.
- Decisao documentada em ADR, RFC, checklist, contrato ou runbook quando houver impacto tecnico ou operacional.
- Validacao manual ou automatizada proporcional ao risco.
- Owner claro para manutencao da evidencia.

## Checklist

- [ ] O item foi marcado como aplicavel, recomendado ou nao aplicavel.
- [ ] A justificativa e compreensivel para uma pessoa nova no projeto.
- [ ] Existe evidencia minima versionada ou rastreavel.
- [ ] O owner sabe como manter este item atualizado.
- [ ] A decisao foi revisada no pull request ou rito equivalente.

## Relacionamentos

- Fonte conceitual: `references.md`.
- Catalogo estruturado: `catalog/pillar-items.yml`.
- Pilar operacional: `docs/pillars/sre/README.md`.
- Checklist universal: `docs/checklists/universal-project-readiness.md`.

## Padroes Relacionados

- [changelog-standard](../../standards/changelog-standard.md)
- [kubernetes-kustomize](../../standards/kubernetes-kustomize.md)
- [secrets-management](../../standards/secrets-management.md)

## Status No Repository

Este item esta documentado como orientacao operacional do template Repository.
Projetos concretos devem registrar evidencia propria quando o item for aplicavel.
