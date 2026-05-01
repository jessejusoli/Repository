import { readFileSync } from "node:fs";
import { join } from "node:path";

export type RepositoryBlueprint = {
  id: string;
  docPath: string;
};

export function readText(root: string, relativePath: string): string {
  return readFileSync(join(root, relativePath), "utf8");
}

export function listBlueprintIds(root: string): string[] {
  const catalog = readText(root, "catalog/repository-blueprints.yml");
  return Array.from(catalog.matchAll(/^  - id: (.+)$/gm), (match) => match[1]);
}

export function listStackIds(root: string): string[] {
  const catalog = readText(root, "catalog/stacks.yml");
  return Array.from(catalog.matchAll(/^  - id: (.+)$/gm), (match) => match[1]);
}

export function listStandardIds(root: string): string[] {
  const catalog = readText(root, "catalog/standards.yml");
  return Array.from(catalog.matchAll(/^  - id: (.+)$/gm), (match) => match[1]);
}

export function listMaturityLevelIds(root: string): string[] {
  const catalog = readText(root, "catalog/project-lifecycle.yml");
  return Array.from(catalog.matchAll(/^  - id: (M[0-5])$/gm), (match) => match[1]);
}

export function listProjectArtifactIds(root: string): string[] {
  const catalog = readText(root, "catalog/project-artifacts.yml");
  return Array.from(catalog.matchAll(/^  - id: (.+)$/gm), (match) => match[1]);
}
