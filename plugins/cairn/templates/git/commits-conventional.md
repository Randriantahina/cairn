# Commits: Conventional Commits, in {{COMMIT_LANGUAGE}}

```
<type>(<scope>): <imperative summary, lower case, no final period, <= 72 chars>

<optional body: why the change was made>
```

Types: `feat` · `fix` · `refactor` (no behaviour change) · `test` · `docs` · `chore` · `build` · `ci` · `perf` · `style` · `revert`.

## Rules
- One logical change per commit, committed only when the gates are green.
- A `feat` or `fix` includes its tests.
- A body explains **why**, not what the diff already shows.
- Never commit `.env`, secrets, dependencies folders, build output, or real personal data.
- No `--no-verify`, no `--amend` on pushed commits.

Good: `fix(auth): reject login after five failures for fifteen minutes`
Bad: `fix stuff` · `update files` · `WIP`
