.PHONY: verify verify-repository verify-pillars verify-contracts verify-agents

verify: verify-repository verify-pillars verify-contracts verify-agents

verify-repository:
	bash scripts/verify-repository.sh

verify-pillars:
	bash scripts/verify-pillar-coverage.sh

verify-contracts:
	bash scripts/verify-contracts.sh

verify-agents:
	bash scripts/verify-agents.sh
