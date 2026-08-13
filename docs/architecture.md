# Deployment Architecture

## Components

| Component | Azure service | Responsibility |
| --- | --- | --- |
| React frontend | Static Web Apps | Public UI, HTTPS and static delivery |
| ASP.NET Core API | App Service | Authentication and business logic |
| SQL Server database | Azure SQL Database | Relational data and stored procedures |
| GitHub Actions | GitHub | Validation and controlled deployment |

## Boundaries

- The frontend never connects directly to SQL.
- The API is the authorization and business-rule boundary.
- Production settings override `appsettings.json` through environment variables.
- GitHub authenticates to Azure with short-lived OIDC tokens.
- API and frontend resources live in `rg-concre-innova-demo` for simple cleanup.
- Azure SQL is an existing external dependency in resource group `Predestinador`.
- Cleanup automation cannot delete or modify the SQL resource group.

## Runtime configuration

Production CORS reads `AllowedOrigins` from configuration. Provisioning sets the
deployed Static Web Apps origin as `AllowedOrigins__0` on the API App Service;
other production origins remain blocked.

Uploaded user images currently use the API filesystem. This is acceptable only
for the short-lived student demo. A durable production deployment should move
uploads to Azure Blob Storage or a mounted Azure Files share.
