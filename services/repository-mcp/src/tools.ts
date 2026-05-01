import type { ToolDefinition } from "./types.js";

export const tools: ToolDefinition[] = [
  {
    name: "list_maturity_levels",
    title: "List Maturity Levels",
    description: "List Repository Forge maturity levels from catalog/project-lifecycle.yml.",
    inputSchema: {
      type: "object",
      additionalProperties: false
    }
  },
  {
    name: "list_project_artifacts",
    title: "List Project Artifacts",
    description: "List project planning artifacts from catalog/project-artifacts.yml.",
    inputSchema: {
      type: "object",
      additionalProperties: false
    }
  },
  {
    name: "list_templates",
    title: "List Repository Templates",
    description: "List repository blueprints from catalog/repository-blueprints.yml.",
    inputSchema: {
      type: "object",
      additionalProperties: false
    }
  },
  {
    name: "inspect_template",
    title: "Inspect Repository Template",
    description: "Inspect one blueprint by id without changing files.",
    inputSchema: {
      type: "object",
      properties: {
        blueprintId: {
          type: "string"
        }
      },
      required: [
        "blueprintId"
      ],
      additionalProperties: false
    }
  },
  {
    name: "generate_repository_plan",
    title: "Generate Repository Plan",
    description: "Generate a non-mutating plan for a new repository.",
    inputSchema: {
      type: "object",
      properties: {
        blueprintId: {
          type: "string"
        },
        projectName: {
          type: "string"
        },
        stackId: {
          type: "string"
        },
        maturityLevel: {
          type: "string",
          enum: [
            "M0",
            "M1",
            "M2",
            "M3",
            "M4",
            "M5"
          ]
        },
        environments: {
          type: "array",
          items: {
            type: "string"
          }
        },
        standardsRefs: {
          type: "array",
          items: {
            type: "string"
          }
        },
        outputFormat: {
          type: "string",
          enum: [
            "markdown",
            "json",
            "both"
          ]
        }
      },
      required: [
        "blueprintId",
        "projectName"
      ],
      additionalProperties: false
    }
  },
  {
    name: "validate_repository",
    title: "Validate Repository",
    description: "Validate repository readiness against catalogs and pillar docs.",
    inputSchema: {
      type: "object",
      properties: {
        path: {
          type: "string"
        }
      },
      required: [
        "path"
      ],
      additionalProperties: false
    }
  },
  {
    name: "search_pillars",
    title: "Search Pillars",
    description: "Search pillar documentation and item catalog.",
    inputSchema: {
      type: "object",
      properties: {
        query: {
          type: "string"
        }
      },
      required: [
        "query"
      ],
      additionalProperties: false
    }
  },
  {
    name: "search_governance",
    title: "Search Governance",
    description: "Search governance, automation and architecture documents.",
    inputSchema: {
      type: "object",
      properties: {
        query: {
          type: "string"
        }
      },
      required: [
        "query"
      ],
      additionalProperties: false
    }
  }
];
