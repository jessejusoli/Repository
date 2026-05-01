# Stack Catalog

`catalog/stacks.yml` documents language and runtime expectations without making
the root repository depend on any specific stack.

## Required Fields

Every stack must define:

- `id`
- `language`
- `runtimes`
- `package_managers`
- `commands.build`
- `commands.test`
- `commands.lint`
- `commands.deploy`

## Usage

Project READMEs should reference a stack id when implementation exists. If a
command is not universal for the stack, use `project-defined` and document the
real command in the project.

## Rule

The root repository stays language-neutral. Stack-specific tooling belongs in
the project, `tooling/` or `services/`.
