# Rollback

## Application rollback

Run `Deploy demo applications` with the previous API and frontend commit SHAs
from `config/release-manifest.yml` or the previous Git tag.

## Database rollback

Database migrations should be forward-fix by default. Before a destructive
migration:

1. Create an Azure SQL point-in-time restore point or export a BACPAC.
2. Verify that the prior API version remains compatible.
3. Document the recovery query and expected data impact.

Never attempt to reverse a production-like migration by deleting columns or
tables without a verified backup.

## Full environment cleanup

Run `Destroy demo environment` and type `DELETE` when the entire student demo
environment can be removed.
