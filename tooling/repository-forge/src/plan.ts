export type RepositoryPlanInput = {
  projectName: string;
  blueprintId: string;
  stackId?: string;
  environments?: string[];
};

export function generateRepositoryPlan(input: RepositoryPlanInput) {
  return {
    projectName: input.projectName,
    blueprintId: input.blueprintId,
    stackId: input.stackId ?? "project-defined",
    environments: input.environments ?? [
      "local"
    ],
    files: [
      "README.md",
      "catalog/projects.yml",
      "docs/templates/PROJECT.md"
    ],
    checks: [
      "make verify",
      "make verify-blueprints",
      "make verify-stacks"
    ]
  };
}
