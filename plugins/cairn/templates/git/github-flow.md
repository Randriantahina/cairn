# Git flow: GitHub Flow

- `{{MAIN_BRANCH}}` is always deployable and protected. Never commit on it.
- One short-lived branch per change: `<type>/<short-slug>` (e.g. `feat/receipt-pdf`, `fix/login-lockout`).
- {{PUSH_STEP}}

## Daily flow
1. Branch from an up-to-date `{{MAIN_BRANCH}}`.
2. Commit small and green; push the branch.
3. Open a pull request; CI must pass; the user decides when to merge.
4. Delete the branch after merge.

## Never
Merge your own pull request without the user's approval, push to `{{MAIN_BRANCH}}`, or keep a branch alive for weeks.
