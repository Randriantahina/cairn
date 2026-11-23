# Git flow: git-flow

- `{{MAIN_BRANCH}}`: production releases only, tagged. `{{DEV_BRANCH}}`: integration.
- `feature/<slug>` from `{{DEV_BRANCH}}`, merged back by pull request.
- `release/<version>` from `{{DEV_BRANCH}}`: stabilisation only, then merged to `{{MAIN_BRANCH}}` and `{{DEV_BRANCH}}`.
- `hotfix/<slug>` from `{{MAIN_BRANCH}}`, merged to both.
- {{PUSH_STEP}}

## Never
Commit directly on `{{MAIN_BRANCH}}` or `{{DEV_BRANCH}}`, force-push, or release without green CI and the user's approval.
