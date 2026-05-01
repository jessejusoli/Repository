import { test } from "node:test";
import assert from "node:assert/strict";
import { readFileSync } from "node:fs";

test("forge source contains plan generator", () => {
  const source = readFileSync(new URL("../src/plan.ts", import.meta.url), "utf8");

  assert.match(source, /generateRepositoryPlan/);
  assert.match(source, /make verify/);
});
