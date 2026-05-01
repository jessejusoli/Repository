.PHONY: verify verify-all verify-repository verify-pillars verify-pillar-docs verify-standards verify-stacks verify-blueprints verify-infra verify-contracts verify-api-contracts verify-rag-profile verify-agents

verify: verify-all

verify-all: verify-repository verify-pillars verify-pillar-docs verify-standards verify-stacks verify-blueprints verify-infra verify-contracts verify-api-contracts verify-rag-profile verify-agents

verify-repository:
	bash scripts/verify-repository.sh

verify-pillars:
	bash scripts/verify-pillar-coverage.sh

verify-pillar-docs:
	bash scripts/verify-pillar-docs.sh

verify-standards:
	bash scripts/verify-standards.sh

verify-stacks:
	bash scripts/verify-stacks.sh

verify-blueprints:
	bash scripts/verify-blueprints.sh

verify-infra:
	bash scripts/verify-infra.sh

verify-contracts:
	bash scripts/verify-contracts.sh

verify-api-contracts:
	bash scripts/verify-api-contracts.sh

verify-rag-profile:
	bash scripts/verify-rag-profile.sh

verify-agents:
	bash scripts/verify-agents.sh
