import { existsSync } from "node:fs";
import { resolve } from "node:path";

const root = resolve(new URL("../../..", import.meta.url).pathname);

for (const required of [
  "contracts/rag/repository.rag-profile.yml",
  "docs/README.md",
  "catalog/pillar-items.yml",
  "catalog/standards.yml",
  "docs/standards/README.md"
]) {
  if (!existsSync(resolve(root, required))) {
    throw new Error(`Missing RAG source: ${required}`);
  }
}

console.log("repository-forge rag index preflight ok");
