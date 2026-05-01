import { cwd } from "node:process";
import { listBlueprintIds, listStackIds } from "./catalog.js";
import { generateRepositoryPlan } from "./plan.js";

const command = process.argv[2] ?? "help";

if (command === "list-blueprints") {
  console.log(JSON.stringify(listBlueprintIds(cwd()), null, 2));
} else if (command === "list-stacks") {
  console.log(JSON.stringify(listStackIds(cwd()), null, 2));
} else if (command === "plan") {
  const projectName = process.argv[3] ?? "example-project";
  const blueprintId = process.argv[4] ?? "api-service";
  console.log(JSON.stringify(generateRepositoryPlan({ projectName, blueprintId }), null, 2));
} else {
  console.log("Usage: repository-forge <list-blueprints|list-stacks|plan>");
}
