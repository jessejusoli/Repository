import { existsSync, readFileSync } from "node:fs";

for (const file of [
  "src/server.ts",
  "src/tools.ts",
  "src/resources.ts",
  "src/types.ts"
]) {
  if (!existsSync(new URL(`../${file}`, import.meta.url))) {
    throw new Error(`Missing source file: ${file}`);
  }
}

const packageJson = readFileSync(new URL("../package.json", import.meta.url), "utf8");
if (!packageJson.includes("\"typecheck\"")) {
  throw new Error("package.json must expose typecheck for real TypeScript builds");
}

console.log("repository-mcp build preflight ok");
