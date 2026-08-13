# Concre Innova Deployment

Infrastructure and deployment automation for the public Concre Innova student
demo.

Application source remains in:

- API: `Eguzjimenez/e-commerce-api`
- Frontend: `Eguzjimenez/e-commerce`

This repository creates and manages:

- Azure App Service for the ASP.NET Core API.
- Azure Static Web Apps for the React frontend.
- GitHub Actions workflows for validation, provisioning, deployment and cleanup.

The demo reuses the existing `ConcreInnovaDB` Azure SQL database. Its server and
resource group are external dependencies and are never created or deleted here.

## Deployment model

```text
Browser
  -> Azure Static Web Apps (React)
  -> Azure App Service (.NET API)
  -> Azure SQL Database
```

`main` represents the version approved for the GitHub `demo` environment.
Application versions are pinned in
[`config/release-manifest.yml`](config/release-manifest.yml).

## Prerequisites

- Azure for Students subscription.
- GitHub repository environment named `demo`.
- OIDC federation between this repository and Azure.
- Existing Azure SQL database initialized from a reviewed script or BACPAC.
- Production CORS configured in the API.

## First deployment

1. Configure the GitHub settings described in
   [`docs/deployment.md`](docs/deployment.md).
2. Run `Verify Azure OIDC`.
3. Run `Provision demo infrastructure`.
4. Initialize the existing empty `ConcreInnovaDB` database from a reviewed
   script or BACPAC.
5. Set `API_BASE_URL` and the Azure resource-name repository variables.
6. Run `Deploy demo applications`.
7. Complete [`docs/demo-checklist.md`](docs/demo-checklist.md).

## Cost control

API and frontend resources are placed in `rg-concre-innova-demo`. Create a
student-subscription budget before provisioning. Run `Destroy demo environment`
after the presentation when the application environment is no longer required.
The existing database in `Predestinador` is excluded from cleanup.

## Security

No secret belongs in Git. See [`SECURITY.md`](SECURITY.md).
