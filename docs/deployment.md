# Demo Deployment Runbook

## 1. GitHub repository settings

Create a GitHub environment named `demo` and restrict deployment to `main`.
Add these environment secrets:

```text
AZURE_CLIENT_ID
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID
SQL_ADMIN_PASSWORD
JWT_KEY
EMAIL_USERNAME
EMAIL_PASSWORD
```

Add these repository variables after provisioning:

```text
AZURE_RESOURCE_GROUP
AZURE_API_APP_NAME
AZURE_STATIC_WEB_APP_NAME
API_BASE_URL
```

`API_BASE_URL` must include `https://` and no trailing slash.

## 2. Configure Azure OIDC

Create a Microsoft Entra application or user-assigned managed identity with a
federated credential for:

```text
repo:valverdegit/concre-innova-deployment:environment:demo
```

Grant only the permissions needed for the demo resource group.

## 3. Provision resources

Run the `Provision demo infrastructure` workflow manually. Record its outputs
as the repository variables listed above.

## 4. Initialize the database

For the first student demonstration, export a reviewed local database to a
BACPAC and import it into the Azure SQL database. Remove personal information,
password-reset records and uploaded files before export.

The BACPAC is an initialization artifact and must not be committed to Git.
Future schema changes remain versioned in the API repository under
`Concre_Innova_API/Database/Scripts`.

## 5. Deploy applications

Run `Deploy demo applications`. Keep the default immutable commit SHAs or enter
new reviewed SHAs from the two source repositories.

The workflow:

1. Builds and tests the API.
2. Publishes the API to App Service.
3. Runs an API smoke test.
4. Builds and tests React with the deployed API URL.
5. Publishes the frontend to Static Web Apps.
6. Runs a public web smoke test.

## 6. Validate

Complete `docs/demo-checklist.md` and record the URLs in the release notes.
