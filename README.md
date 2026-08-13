# Concre Innova Deployment

Infrastructure and deployment automation for the public Concre Innova student
demo.

Application source remains in:

- API: `Eguzjimenez/e-commerce-api`
- Frontend: `Eguzjimenez/e-commerce`

This repository creates and manages:

- Azure App Service for the ASP.NET Core API.
- Azure Static Web Apps for the React frontend.
- Azure SQL Database for `ConcreInnovaDB`.
- GitHub Actions workflows for validation, provisioning, deployment and cleanup.

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
- Initial database imported from a reviewed BACPAC.
- Production CORS configured in the API.

## First deployment

1. Configure the GitHub settings described in
   [`docs/deployment.md`](docs/deployment.md).
2. Run `Provision demo infrastructure`.
3. Import the reviewed `ConcreInnovaDB.bacpac` into the generated Azure SQL
   database.
4. Set `API_BASE_URL` and the Azure resource-name repository variables.
5. Run `Deploy demo applications`.
6. Complete [`docs/demo-checklist.md`](docs/demo-checklist.md).

## Cost control

All resources are placed in one resource group. Create a student-subscription
budget before provisioning. Run `Destroy demo environment` after the
presentation when the environment is no longer required.

## Security

No secret belongs in Git. See [`SECURITY.md`](SECURITY.md).
