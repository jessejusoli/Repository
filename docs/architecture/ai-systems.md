# AI Systems

AI systems in this monorepo are governed through explicit contracts and safety
boundaries.

## MCP

MCP clients and servers are registered in `contracts/mcp/registry.yml`.

Each integration must document:

- Host and client.
- Server capabilities.
- Transport.
- Auth model.
- Data boundaries.
- Tool allowlists.
- Audit expectations.

`services/repository-mcp/` contains the future TypeScript/Node server skeleton.

## RAG

RAG systems use profiles based on `contracts/rag/rag-profile.template.yml`.

Each RAG system must document:

- Corpus and owner.
- Data classification.
- Ingestion and retention.
- Chunking and indexing.
- Retrieval strategy.
- Evaluation metrics.
- Safety controls.

`contracts/rag/repository.rag-profile.yml` defines the repository knowledge base
corpus. Generated indexes belong in `.rag/` and must not be committed.

## Rule

Model-facing systems should be designed as production systems, not prompt files.
They need ownership, tests, observability, security and rollback expectations.
