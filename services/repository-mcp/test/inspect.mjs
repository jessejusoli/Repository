import { readFileSync } from "node:fs";

const toolsSource = readFileSync(new URL("../src/tools.ts", import.meta.url), "utf8");
const resourcesSource = readFileSync(new URL("../src/resources.ts", import.meta.url), "utf8");

for (const tool of [
  "list_templates",
  "inspect_template",
  "generate_repository_plan",
  "validate_repository",
  "search_pillars",
  "search_governance"
]) {
  if (!toolsSource.includes(`name: \"${tool}\"`)) {
    throw new Error(`Missing MCP tool: ${tool}`);
  }
}

for (const resource of [
  "repository://catalog/pillars",
  "repository://catalog/stacks",
  "repository://templates",
  "repository://docs/pillars/{pillar}/{item}"
]) {
  if (!resourcesSource.includes(resource)) {
    throw new Error(`Missing MCP resource: ${resource}`);
  }
}

console.log("repository-mcp inspection ok");
