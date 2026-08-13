# Demonstration Checklist

## Infrastructure

- [ ] Budget and alerts are enabled for the student subscription.
- [ ] API and frontend use HTTPS.
- [ ] Azure SQL accepts connections only as required for the demo.
- [ ] No secrets are present in GitHub files or workflow logs.

## Runtime

- [ ] Public catalog loads products from Azure SQL.
- [ ] Login works for each demonstration role.
- [ ] Client, seller and administrator permissions are enforced by the API.
- [ ] Cart, checkout, orders and quotations persist after browser refresh.
- [ ] Uploaded images remain available during the demonstration.
- [ ] Email behavior is understood as Mailtrap Sandbox testing.

## Recovery

- [ ] The release manifest contains the deployed commit SHAs.
- [ ] A database backup or BACPAC exists outside Git.
- [ ] The cleanup workflow has been reviewed but not accidentally executed.
