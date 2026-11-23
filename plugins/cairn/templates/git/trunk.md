# Git flow: trunk-based on `{{MAIN_BRANCH}}`

- Work happens on `{{MAIN_BRANCH}}` in small commits; it must always be releasable.
- Anything risky or unfinished is hidden behind a flag or kept out of the commit.
- {{PUSH_STEP}}

## Daily flow
1. `git status --short` and `git log --oneline -5` first.
2. One logical change per commit, only when the gates are green.
3. Pull and rebase before pushing so history stays linear.

## Never
Commit a red state, force-push, or rewrite pushed history.
