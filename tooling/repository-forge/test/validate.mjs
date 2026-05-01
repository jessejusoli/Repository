import { existsSync, readFileSync } from "node:fs";
import { resolve } from "node:path";

const root = resolve(new URL("../../..", import.meta.url).pathname);
const blueprints = readFileSync(resolve(root, "catalog/repository-blueprints.yml"), "utf8");
const stacks = readFileSync(resolve(root, "catalog/stacks.yml"), "utf8");
const standards = readFileSync(resolve(root, "catalog/standards.yml"), "utf8");

if (!blueprints.includes("api-service")) {
  throw new Error("Missing api-service blueprint");
}

if (!stacks.includes("node-typescript")) {
  throw new Error("Missing node-typescript stack");
}

if (!standards.includes("repository-baseline")) {
  throw new Error("Missing repository-baseline standard");
}

if (!existsSync(resolve(root, "docs/pillars/README.md"))) {
  throw new Error("Missing pillar docs");
}

console.log("repository-forge validation ok");
