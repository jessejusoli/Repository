# RAG Guidance

Retrieval-augmented generation systems must be designed as data products and
software systems at the same time.

## Required Decisions

- Corpus scope and owner.
- Data classification and retention.
- Ingestion schedule.
- Chunking strategy.
- Embedding model and vector store.
- Retrieval strategy and reranking.
- Evaluation set and quality metrics.
- Hallucination, privacy and prompt-injection controls.

## Evidence

Each RAG system should include a profile based on
`contracts/rag/rag-profile.template.yml`.
