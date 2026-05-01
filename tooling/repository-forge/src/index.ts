import { cwd } from "node:process";
import { listBlueprintIds, listMaturityLevelIds, listProjectArtifactIds, listStackIds, listStandardIds } from "./catalog.js";
import { formatRepositoryPlan, generateRepositoryPlan, type MaturityLevel, type OutputFormat } from "./plan.js";

const command = process.argv[2] ?? "help";

if (command === "list-blueprints") {
  console.log(JSON.stringify(listBlueprintIds(cwd()), null, 2));
} else if (command === "list-stacks") {
  console.log(JSON.stringify(listStackIds(cwd()), null, 2));
} else if (command === "list-standards") {
  console.log(JSON.stringify(listStandardIds(cwd()), null, 2));
} else if (command === "list-maturity-levels") {
  console.log(JSON.stringify(listMaturityLevelIds(cwd()), null, 2));
} else if (command === "list-project-artifacts") {
  console.log(JSON.stringify(listProjectArtifactIds(cwd()), null, 2));
} else if (command === "plan") {
  const projectName = process.argv[3] ?? "example-project";
  const blueprintId = process.argv[4] ?? "api-service";
  const stackId = process.argv[5] ?? "node-typescript";
  const maturityLevel = (process.argv[6] ?? "M2") as MaturityLevel;
  const outputFormat = (process.argv[7] ?? "both") as OutputFormat;
  const plan = generateRepositoryPlan({ projectName, blueprintId, stackId, maturityLevel, outputFormat });

  console.log(formatRepositoryPlan(plan, outputFormat));
} else {
  console.log("Usage: repository-forge <list-blueprints|list-stacks|list-standards|list-maturity-levels|list-project-artifacts|plan>");
}
