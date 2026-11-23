# Git flow: `{{DEV_BRANCH}}` + `{{MAIN_BRANCH}}`

- `{{MAIN_BRANCH}}`: stable. Never commit on it directly. It only receives `{{DEV_BRANCH}}` through a pull request with green CI.
- `{{DEV_BRANCH}}`: the single working branch. Every feat, fix, refactor, test, docs and chore is committed here. No per-feature branches unless the user asks.

## Daily flow
1. `git branch --show-current` must print `{{DEV_BRANCH}}`; otherwise stop and ask (dirty tree).
2. One logical change per commit, committed once the gates are green.
3. {{PUSH_STEP}}
4. Promote to `{{MAIN_BRANCH}}` only when the user asks: open a PR `{{DEV_BRANCH}}` → `{{MAIN_BRANCH}}`, wait for CI.

## Never
Force-push, rewrite pushed history, delete `{{MAIN_BRANCH}}` or `{{DEV_BRANCH}}`, merge into `{{MAIN_BRANCH}}` without green CI and the user's approval.
