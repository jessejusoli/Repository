import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";

export type RagDocument = {
  path: string;
  title: string;
};

export function writeLocalIndex(root: string, documents: RagDocument[]) {
  const indexPath = join(root, ".rag", "repository-index.json");
  mkdirSync(dirname(indexPath), {
    recursive: true
  });
  writeFileSync(
    indexPath,
    JSON.stringify(
      {
        schema_version: 1,
        generated_by: "repository-forge",
        documents
      },
      null,
      2
    )
  );
  return indexPath;
}
