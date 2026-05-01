import { resources } from "./resources.js";
import { tools } from "./tools.js";

type JsonRpcRequest = {
  jsonrpc: "2.0";
  id?: number | string;
  method: string;
  params?: unknown;
};

function result(id: number | string | undefined, value: unknown) {
  return {
    jsonrpc: "2.0",
    id,
    result: value
  };
}

function error(id: number | string | undefined, code: number, message: string) {
  return {
    jsonrpc: "2.0",
    id,
    error: {
      code,
      message
    }
  };
}

export function handleRequest(request: JsonRpcRequest) {
  if (request.method === "initialize") {
    return result(request.id, {
      protocolVersion: "2025-11-25",
      serverInfo: {
        name: "repository-mcp",
        version: "0.1.0"
      },
      capabilities: {
        tools: {
          listChanged: false
        },
        resources: {
          listChanged: false
        },
        prompts: {
          listChanged: false
        }
      }
    });
  }

  if (request.method === "tools/list") {
    return result(request.id, {
      tools
    });
  }

  if (request.method === "resources/list") {
    return result(request.id, {
      resources
    });
  }

  if (request.method === "tools/call") {
    return result(request.id, {
      content: [
        {
          type: "text",
          text: "Repository MCP is in planning mode. Use tooling/repository-forge for local validation."
        }
      ],
      isError: false
    });
  }

  return error(request.id, -32601, `Unknown method: ${request.method}`);
}

export function inspect() {
  return {
    tools: tools.map((tool) => tool.name),
    resources: resources.map((resource) => resource.uri)
  };
}
