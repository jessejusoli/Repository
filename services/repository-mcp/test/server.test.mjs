import { test } from "node:test";
import assert from "node:assert/strict";
import { readFileSync } from "node:fs";

test("server declares MCP methods", () => {
  const source = readFileSync(new URL("../src/server.ts", import.meta.url), "utf8");

  assert.match(source, /initialize/);
  assert.ok(source.includes("tools/list"));
  assert.ok(source.includes("resources/list"));
  assert.ok(source.includes("tools/call"));
});
