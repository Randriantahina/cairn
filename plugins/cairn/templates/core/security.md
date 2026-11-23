# Safety

Rules are advice; permissions and hooks are the real locks. These are the habits.

## Never
- Put secrets, tokens or real personal data in code, tests, memory or commit messages.
- Read or print `.env*` files; ask the user for a value instead.
- Run a destructive command (drop, truncate, `rm -rf`, `reset --hard`, force-push, migrate-rollback) without the user's explicit approval for that exact command.
- Weaken a check to get green: skip a test, lower coverage, disable a lint rule, `--no-verify`.

## Always
- Ask before a database migration on a shared or production database.
- Validate input at the boundary; never trust client data.
- Install only through `{{PACKAGE_MANAGER}}`; do not add another package manager's lockfile.
- Look at the target before deleting or overwriting it.

Good: "this migration drops a column; confirm before I run it."
Bad: running it because the test database allowed it.
