# Modelo Universal de Projetos

O Repository deve funcionar para qualquer linguagem de programacao, runtime,
ambiente e dominio. Para isso, ele separa duas coisas:

- Estrutura do repositorio: onde cada tipo de artefato vive.
- Cobertura de projeto: quais pilares precisam ser considerados.

Os pilares nao sao departamentos fixos. Eles sao lentes de verificacao para
evitar pontos cegos quando um projeto nasce, cresce ou entra em producao.

## Fonte de referencia

`references.md` e a versao extensa da arquitetura. `catalog/pillars.yml` e a
versao estruturada para automacao, inventario e checklists.

## Pilares

| Pilar | Quando se aplica | Evidencia esperada |
| --- | --- | --- |
| Front-end | Existe interface visual, mobile, web, desktop ou CLI interativa. | Acessibilidade, responsividade, estados, testes de interface. |
| Back-end | Existe regra de negocio, API, worker ou processamento server-side. | Contratos, validacao, auth, persistencia e testes. |
| Infraestrutura | O projeto depende de recursos computacionais ou ambientes. | IaC, redes, storage, backup, ambientes e custos. |
| DevOps | O projeto precisa de build, teste, entrega ou deploy. | Pipeline, artefatos, release, rollback e metricas. |
| Seguranca | O projeto manipula acesso, dados, execucao ou superficie externa. | Threat model, segredos, scans, permissoes e incident response. |
| QA | Ha comportamento que precisa ser validado com confianca. | Estrategia de testes, cobertura, regressao e criterios de aceite. |
| Dados | O projeto cria, processa, analisa ou treina dados/modelos. | Modelagem, lineage, qualidade, privacidade e pipelines. |
| Produto/UX | Existe usuario, operador, cliente ou stakeholder final. | Problema, jornada, criterios de aceite e metricas de valor. |
| Architecture | A decisao afeta evolucao, integracao, escala ou acoplamento. | ADRs, diagramas, trade-offs e requisitos nao funcionais. |
| SRE | O projeto opera em producao ou precisa de confiabilidade mensuravel. | SLIs/SLOs, alertas, runbooks, DR e post-mortems. |
| IT Governance | Ha risco regulatorio, financeiro, estrategico ou organizacional. | Ownership, compliance, matriz de risco e accountability. |
| DevEx | Outras pessoas precisam desenvolver, rodar ou manter o projeto. | Setup claro, comandos, ambiente reproduzivel e baixa friccao. |
| Sustainability | O projeto consome recursos relevantes ou tem impacto ESG. | Medicao, right-sizing, eficiencia e reducao de desperdicio. |

## Como classificar um novo projeto

1. Identifique o tipo: `app`, `package`, `service`, `infra`, `tooling`,
   `example` ou outro tipo documentado.
2. Liste linguagens, runtimes e ambientes suportados.
3. Marque pilares aplicaveis no README do projeto.
4. Registre os mesmos pilares em `catalog/projects.yml`.
5. Use `docs/checklists/universal-project-readiness.md` para decidir o minimo
   necessario antes do primeiro PR, primeiro release e primeira producao.

## Regra de ouro

Todo projeto deve cobrir pelo menos:

- Owner claro.
- Setup reproduzivel.
- Validacao minima.
- Riscos conhecidos.
- Modelo de evolucao.

Projetos simples podem declarar varios pilares como `nao aplicavel`. O ponto e
tomar a decisao conscientemente, nao fingir que a area nao existe.
