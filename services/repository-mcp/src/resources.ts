import type { ResourceDefinition } from "./types.js";

export const resources: ResourceDefinition[] = [
  {
    uri: "repository://catalog/pillars",
    name: "Pillar Catalog",
    description: "The 13 universal pillars.",
    mimeType: "application/x-yaml"
  },
  {
    uri: "repository://catalog/stacks",
    name: "Stack Catalog",
    description: "Language and runtime stack catalog.",
    mimeType: "application/x-yaml"
  },
  {
    uri: "repository://templates",
    name: "Repository Blueprints",
    description: "Available repository blueprints.",
    mimeType: "application/x-yaml"
  },
  {
    uri: "repository://docs/pillars/{pillar}/{item}",
    name: "Pillar Item Documentation",
    description: "Operational guide for a pillar item.",
    mimeType: "text/markdown"
  }
];
