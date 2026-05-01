# Checklist Universal de Cobertura

Use este checklist para qualquer projeto, de qualquer linguagem ou ambiente.
Marque cada item como `Done`, `Planned` ou `N/A`.

## Identidade

- Nome, objetivo e publico-alvo definidos.
- Tipo registrado em `catalog/projects.yml`.
- Owner registrado em `catalog/owners.yml`.
- Linguagens, runtimes e ambientes documentados.
- Pilares aplicaveis listados no README do projeto.

## Pilares

| Pilar | Pergunta de cobertura |
| --- | --- |
| Front-end | Existe interface? Como ficam acessibilidade, responsividade, estados e testes? |
| Back-end | Existem APIs, regras, workers ou persistencia? Como contratos e erros sao tratados? |
| Infraestrutura | Quais recursos, redes, storage e ambientes precisam existir? |
| DevOps | Como build, testes, deploy, rollback e release acontecem? |
| Seguranca | Quais dados, permissoes, segredos e ameacas precisam de controle? |
| QA | Qual estrategia prova que o comportamento esperado funciona? |
| Dados | Ha coleta, transformacao, modelo, BI, ML ou IA? Como qualidade e privacidade entram? |
| Produto/UX | Qual usuario ou operador recebe valor? Como o sucesso sera medido? |
| Architecture | Quais decisoes estruturais merecem ADR ou diagrama? |
| SRE | Quais SLOs, alertas, runbooks e planos de incidente sao necessarios? |
| IT Governance | Existe compliance, risco, auditoria, custo ou accountability formal? |
| DevEx | Uma pessoa nova consegue rodar, testar e entender o projeto rapidamente? |
| Sustainability | O projeto desperdicaria compute, storage, rede ou energia sem controle? |

## Antes do primeiro PR

- README do projeto criado a partir de `docs/templates/PROJECT.md`.
- Pilares aplicaveis definidos.
- Setup local documentado.
- Validacao minima documentada ou automatizada.
- Riscos iniciais registrados.

## Antes do primeiro release

- Pipeline ou processo de build definido.
- Politica de versao definida.
- Changelog ou release notes definidos.
- Plano de rollback conhecido.
- Owners revisaram os pilares criticos.

## Antes de producao

- Segredos fora do repositorio.
- Observabilidade minima disponivel.
- Incidentes e suporte definidos.
- Backup/DR avaliados quando aplicavel.
- Custos e sustentabilidade avaliados quando aplicavel.
