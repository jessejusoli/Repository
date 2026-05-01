export type MaturityLevel = "M0" | "M1" | "M2" | "M3" | "M4" | "M5";
export type OutputFormat = "markdown" | "json" | "both";

export type RepositoryPlanInput = {
  projectName: string;
  blueprintId: string;
  stackId?: string;
  maturityLevel?: MaturityLevel;
  environments?: string[];
  standardsRefs?: string[];
  outputFormat?: OutputFormat;
};

export type RepositoryPlan = {
  identity: {
    projectName: string;
  };
  blueprint: {
    id: string;
    pillars: string[];
  };
  stack: {
    id: string;
  };
  maturity: {
    level: MaturityLevel;
    name: string;
  };
  environments: string[];
  recommendedArtifacts: string[];
  standardsRefs: string[];
  phases: string[];
  milestones: string[];
  backlog: string[];
  gates: string[];
  checks: string[];
  nextActions: string[];
};

const maturityNames: Record<MaturityLevel, string> = {
  M0: "Concept",
  M1: "Repository Baseline",
  M2: "MVP Ready",
  M3: "Beta Validation",
  M4: "Production Ready",
  M5: "Scale Governance"
};

const maturityArtifacts: Record<MaturityLevel, string[]> = {
  M0: [
    "SCOPE",
    "BACKLOG"
  ],
  M1: [
    "SCOPE",
    "BACKLOG",
    "README",
    "LICENSE_DECISION",
    "AGENTS",
    "CODEOWNERS",
    "CHANGELOG",
    "CI_HEALTH"
  ],
  M2: [
    "SCOPE",
    "BACKLOG",
    "README",
    "LICENSE_DECISION",
    "AGENTS",
    "CODEOWNERS",
    "CHANGELOG",
    "CI_HEALTH",
    "SETUP",
    "USAGE_EXAMPLES",
    "MVP",
    "ROADMAP",
    "MILESTONES",
    "TEST_STRATEGY"
  ],
  M3: [
    "SCOPE",
    "BACKLOG",
    "README",
    "LICENSE_DECISION",
    "AGENTS",
    "CODEOWNERS",
    "CHANGELOG",
    "CI_HEALTH",
    "SETUP",
    "USAGE_EXAMPLES",
    "MVP",
    "ROADMAP",
    "MILESTONES",
    "TEST_STRATEGY",
    "RELEASE_NOTES",
    "API_CONTRACT",
    "OBSERVABILITY",
    "SECURITY_REVIEW"
  ],
  M4: [
    "SCOPE",
    "BACKLOG",
    "README",
    "LICENSE_DECISION",
    "AGENTS",
    "CODEOWNERS",
    "CHANGELOG",
    "CI_HEALTH",
    "SETUP",
    "USAGE_EXAMPLES",
    "MVP",
    "ROADMAP",
    "MILESTONES",
    "TEST_STRATEGY",
    "RELEASE_NOTES",
    "API_CONTRACT",
    "OBSERVABILITY",
    "SECURITY_REVIEW",
    "DEPLOYMENT",
    "SECRETS",
    "SLO",
    "INCIDENT_RUNBOOK",
    "ROLLBACK",
    "SBOM_SCORECARD"
  ],
  M5: [
    "SCOPE",
    "BACKLOG",
    "README",
    "LICENSE_DECISION",
    "AGENTS",
    "CODEOWNERS",
    "CHANGELOG",
    "CI_HEALTH",
    "SETUP",
    "USAGE_EXAMPLES",
    "MVP",
    "ROADMAP",
    "MILESTONES",
    "TEST_STRATEGY",
    "RELEASE_NOTES",
    "API_CONTRACT",
    "OBSERVABILITY",
    "SECURITY_REVIEW",
    "DEPLOYMENT",
    "SECRETS",
    "SLO",
    "INCIDENT_RUNBOOK",
    "ROLLBACK",
    "SBOM_SCORECARD",
    "COMPLIANCE",
    "COST_SUSTAINABILITY",
    "IMPROVEMENT_LOOP"
  ]
};

const blueprintPillars: Record<string, string[]> = {
  "web-app": [
    "front_end",
    "devops",
    "security",
    "quality_assurance",
    "product_ux",
    "developer_experience"
  ],
  "api-service": [
    "back_end",
    "devops",
    "security",
    "quality_assurance",
    "architecture",
    "sre"
  ],
  "cli-tool": [
    "developer_experience",
    "quality_assurance",
    "security"
  ],
  "package-library": [
    "architecture",
    "quality_assurance",
    "developer_experience"
  ],
  "background-worker": [
    "back_end",
    "devops",
    "security",
    "sre"
  ],
  "data-pipeline": [
    "data",
    "security",
    "quality_assurance",
    "sre"
  ],
  "rag-app": [
    "data",
    "security",
    "architecture",
    "quality_assurance",
    "developer_experience"
  ],
  "mcp-server": [
    "back_end",
    "security",
    "architecture",
    "developer_experience",
    "sre"
  ]
};

const blueprintStandards: Record<string, string[]> = {
  "web-app": [
    "repository-baseline",
    "readme-standard",
    "github-actions-ci-cd",
    "openapi",
    "swagger-ui",
    "docker-compose",
    "kubernetes-kustomize",
    "supply-chain-baseline"
  ],
  "api-service": [
    "repository-baseline",
    "readme-standard",
    "github-actions-ci-cd",
    "openapi",
    "swagger-ui",
    "postman-collections",
    "docker-compose",
    "kubernetes-kustomize",
    "secrets-management",
    "supply-chain-baseline"
  ],
  "cli-tool": [
    "repository-baseline",
    "readme-standard",
    "license-spdx",
    "changelog-standard",
    "github-actions-ci-cd",
    "agents-md",
    "supply-chain-baseline"
  ],
  "package-library": [
    "repository-baseline",
    "readme-standard",
    "license-spdx",
    "changelog-standard",
    "github-actions-ci-cd",
    "dependabot",
    "supply-chain-baseline",
    "sbom-scorecard-ready"
  ],
  "background-worker": [
    "repository-baseline",
    "readme-standard",
    "github-actions-ci-cd",
    "docker-compose",
    "kubernetes-kustomize",
    "secrets-management",
    "supply-chain-baseline"
  ],
  "data-pipeline": [
    "repository-baseline",
    "readme-standard",
    "github-actions-ci-cd",
    "rag-systems",
    "docker-compose",
    "kubernetes-kustomize",
    "secrets-management",
    "supply-chain-baseline"
  ],
  "rag-app": [
    "repository-baseline",
    "readme-standard",
    "github-actions-ci-cd",
    "openapi",
    "postman-collections",
    "mcp-server-client",
    "rag-systems",
    "secrets-management",
    "supply-chain-baseline"
  ],
  "mcp-server": [
    "repository-baseline",
    "readme-standard",
    "github-actions-ci-cd",
    "mcp-server-client",
    "openapi",
    "docker-compose",
    "kubernetes-kustomize",
    "secrets-management",
    "supply-chain-baseline"
  ]
};

const maturityGates: Record<MaturityLevel, string[]> = {
  M0: [
    "go-no-go-decision",
    "owner-confirmed",
    "risk-log-created"
  ],
  M1: [
    "repository-health-passes",
    "license-decision-recorded",
    "owners-defined"
  ],
  M2: [
    "setup-reproduced",
    "mvp-scope-approved",
    "minimum-validation-defined"
  ],
  M3: [
    "beta-release-reviewed",
    "critical-risks-owned",
    "observability-smoke-tested"
  ],
  M4: [
    "production-readiness-review",
    "rollback-tested-or-accepted",
    "secrets-not-in-repo"
  ],
  M5: [
    "governance-review",
    "cost-and-sustainability-review",
    "improvement-loop-active"
  ]
};

export function generateRepositoryPlan(input: RepositoryPlanInput): RepositoryPlan {
  const maturityLevel = input.maturityLevel && maturityNames[input.maturityLevel] ? input.maturityLevel : "M2";
  const standardsRefs = input.standardsRefs ?? blueprintStandards[input.blueprintId] ?? [
    "repository-baseline",
    "readme-standard",
    "github-actions-ci-cd"
  ];

  return {
    identity: {
      projectName: input.projectName
    },
    blueprint: {
      id: input.blueprintId,
      pillars: blueprintPillars[input.blueprintId] ?? [
        "developer_experience",
        "quality_assurance",
        "security"
      ]
    },
    stack: {
      id: input.stackId ?? "project-defined"
    },
    maturity: {
      level: maturityLevel,
      name: maturityNames[maturityLevel]
    },
    environments: input.environments ?? [
      "local"
    ],
    recommendedArtifacts: maturityArtifacts[maturityLevel],
    standardsRefs,
    phases: [
      "scope",
      "baseline",
      "mvp",
      "validation",
      "production",
      "scale"
    ],
    milestones: [
      "scope-approved",
      "repository-baseline-ready",
      "mvp-ready",
      "beta-ready",
      "production-ready"
    ],
    backlog: [
      "define-scope",
      "create-repository-baseline",
      "document-setup",
      "define-mvp",
      "wire-validation"
    ],
    gates: maturityGates[maturityLevel],
    checks: [
      "make verify",
      "make verify-forge-model",
      "make verify-standards",
      "make verify-blueprints",
      "make verify-stacks"
    ],
    nextActions: [
      "Review the generated Markdown plan with the project owner.",
      "Confirm maturity level and applicable artifacts before scaffolding.",
      "Record accepted risks and not-applicable pillars."
    ]
  };
}

export function renderRepositoryPlanMarkdown(plan: RepositoryPlan): string {
  return [
    `# Repository Plan: ${plan.identity.projectName}`,
    "",
    `- Blueprint: ${plan.blueprint.id}`,
    `- Stack: ${plan.stack.id}`,
    `- Maturity: ${plan.maturity.level} ${plan.maturity.name}`,
    `- Environments: ${plan.environments.join(", ")}`,
    "",
    "## Artifacts",
    "",
    ...plan.recommendedArtifacts.map((artifact) => `- ${artifact}`),
    "",
    "## Standards",
    "",
    ...plan.standardsRefs.map((standard) => `- ${standard}`),
    "",
    "## Pillars",
    "",
    ...plan.blueprint.pillars.map((pillar) => `- ${pillar}`),
    "",
    "## Gates",
    "",
    ...plan.gates.map((gate) => `- ${gate}`),
    "",
    "## Checks",
    "",
    ...plan.checks.map((check) => `- ${check}`),
    "",
    "## Next Actions",
    "",
    ...plan.nextActions.map((action) => `- ${action}`),
    ""
  ].join("\n");
}

export function formatRepositoryPlan(plan: RepositoryPlan, outputFormat: OutputFormat = "both"): string {
  if (outputFormat === "markdown") {
    return renderRepositoryPlanMarkdown(plan);
  }

  if (outputFormat === "json") {
    return JSON.stringify(plan, null, 2);
  }

  return [
    renderRepositoryPlanMarkdown(plan),
    "```json",
    JSON.stringify(plan, null, 2),
    "```"
  ].join("\n");
}
