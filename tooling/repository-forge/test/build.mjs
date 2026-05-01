import { existsSync, readFileSync } from "node:fs";

for (const file of [
  "src/index.ts",
  "src/catalog.ts",
  "src/plan.ts",
  "src/rag.ts"
]) {
  if (!existsSync(new URL(`../${file}`, import.meta.url))) {
    throw new Error(`Missing source file: ${file}`);
  }
}

const packageJson = readFileSync(new URL("../package.json", import.meta.url), "utf8");
if (!packageJson.includes("\"typecheck\"")) {
  throw new Error("package.json must expose typecheck for real TypeScript builds");
}

console.log("repository-forge build preflight ok");
