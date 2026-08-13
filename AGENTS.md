# AGENTS.md - Concre Innova Deployment

## Scope

This repository owns deployment automation and Azure infrastructure for the
Concre Innova demo environment. Application source code remains in the API and
frontend repositories.

## Rules

- Never copy application source code into this repository.
- Never commit passwords, connection strings, tokens, certificates, or real
  customer information.
- Keep infrastructure reproducible through Bicep and GitHub Actions.
- Use immutable commit SHAs or release tags in `config/release-manifest.yml`.
- Treat `main` as the version authorized for the Azure `demo` environment.
- Apply changes through short-lived branches and pull requests.
- Database changes must remain backward compatible with the deployed API.
- Destructive workflows must require explicit typed confirmation.

## Validation

- Compile Bicep before merging infrastructure changes.
- Validate PowerShell syntax for scripts.
- Run application builds and tests before deployment.
- Run API and web smoke tests after deployment.
