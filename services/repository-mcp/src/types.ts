export type ToolDefinition = {
  name: string;
  title: string;
  description: string;
  inputSchema: {
    type: "object";
    properties?: Record<string, unknown>;
    required?: string[];
    additionalProperties?: boolean;
  };
};

export type ResourceDefinition = {
  uri: string;
  name: string;
  description: string;
  mimeType: string;
};
