# Security Policy

## Secrets

Store deployment secrets in the GitHub `demo` environment or Azure App Service
configuration. Never commit:

- SQL administrator passwords or connection strings.
- JWT signing keys.
- SMTP credentials.
- Azure publish profiles or service-principal client secrets.
- Real customer data or uploaded images.

GitHub Actions authenticates to Azure through OpenID Connect. The expected
GitHub secrets are identifiers, not a reusable Azure password:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

Runtime secrets required by provisioning:

- `SQL_ADMIN_PASSWORD`
- `JWT_KEY`
- `EMAIL_USERNAME`
- `EMAIL_PASSWORD`

## Reporting

Do not open a public issue containing a credential or personal information.
Rotate any exposed JWT, SMTP, SQL or Azure credential immediately.
