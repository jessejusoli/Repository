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
    uri: "repository://catalog/standards",
    name: "Standards Catalog",
    description: "Curated standards and pocket guides.",
    mimeType: "application/x-yaml"
  },
  {
    uri: "repository://catalog/project-lifecycle",
    name: "Project Lifecycle Catalog",
    description: "Repository Forge maturity levels from M0 to M5.",
    mimeType: "application/x-yaml"
  },
  {
    uri: "repository://catalog/project-artifacts",
    name: "Project Artifact Catalog",
    description: "Planning artifacts, templates, standards and pillars.",
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
  },
  {
    uri: "repository://standards/{standard_id}",
    name: "Standard Pocket Guide",
    description: "Pocket guide for a standard, practice or technique.",
    mimeType: "text/markdown"
  },
  {
    uri: "repository://pillars/{pillar}/standards",
    name: "Pillar Standards",
    description: "Standards related to a pillar.",
    mimeType: "application/x-yaml"
  },
  {
    uri: "repository://forge/maturity/{level}",
    name: "Forge Maturity Level",
    description: "Operational guidance for one Repository Forge maturity level.",
    mimeType: "application/x-yaml"
  }
];
