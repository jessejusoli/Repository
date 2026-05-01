# Docker Compose Blueprint

This blueprint follows the Compose Specification and stays project-neutral.

## Files

- `compose.yaml`: disabled-by-default service template.
- `.env.example`: example variables without secrets.

## Usage

Copy the blueprint into a project directory or invoke it with an explicit
profile after replacing image, ports and environment values.

```bash
docker compose --profile template -f infra/compose/compose.yaml config
```

Do not place real secrets in Compose files.
