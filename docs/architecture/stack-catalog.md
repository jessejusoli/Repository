# Stack Catalog

`catalog/stacks.yml` documents language and runtime expectations without making
the root repository depend on any specific stack.

## Required Fields

Every stack must define:

- `id`
- `language`
- `runtimes`
- `package_managers`
- `standards_refs`
- `commands.build`
- `commands.test`
- `commands.lint`
- `commands.deploy`

## Usage

Project READMEs should reference a stack id when implementation exists. If a
command is not universal for the stack, use `project-defined` and document the
real command in the project.

Use `standards_refs` to link each stack to the baseline practices it normally
needs, such as CI/CD, Dependabot, supply chain posture or agent instructions.
The details live in `catalog/standards.yml` and `docs/standards/`.

## Rule

The root repository stays language-neutral. Stack-specific tooling belongs in
the project, `tooling/` or `services/`.
