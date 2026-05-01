# Supply Chain Security Baseline

This baseline applies to every project generated from Repository.

## Source

- Require pull requests for protected branches.
- Use CODEOWNERS for sensitive areas.
- Keep generated artifacts out of Git unless they are source-of-truth.
- Pin or review external actions, images and dependencies.

## Build

- Prefer reproducible commands.
- Keep build secrets out of logs.
- Use least-privilege CI permissions.
- Separate build, validation and deploy responsibilities.

## Dependencies

- Register package managers in `catalog/stacks.yml`.
- Use Dependabot or equivalent update automation.
- Document accepted vulnerability risk.
- Avoid committing vendored dependencies unless explicitly justified.

## Runtime

- Use read-only containers when feasible.
- Drop unnecessary Linux capabilities.
- Define resource requests and limits.
- Document network and secret boundaries.
