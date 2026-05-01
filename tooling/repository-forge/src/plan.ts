export type RepositoryPlanInput = {
  projectName: string;
  blueprintId: string;
  stackId?: string;
  environments?: string[];
  standardsRefs?: string[];
};

export function generateRepositoryPlan(input: RepositoryPlanInput) {
  return {
    projectName: input.projectName,
    blueprintId: input.blueprintId,
    stackId: input.stackId ?? "project-defined",
    environments: input.environments ?? [
      "local"
    ],
    standardsRefs: input.standardsRefs ?? [
      "repository-baseline",
      "readme-standard",
      "github-actions-ci-cd"
    ],
    files: [
      "README.md",
      "catalog/projects.yml",
      "docs/templates/PROJECT.md"
    ],
    checks: [
      "make verify",
      "make verify-standards",
      "make verify-blueprints",
      "make verify-stacks"
    ]
  };
}
