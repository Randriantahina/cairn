# Project memory: what goes where

One fact lives in exactly one file. Split by lifespan so the always-read part stays tiny.

| File | Holds | Rewritten | Cap |
|------|-------|-----------|-----|
| `memory/status.md` | now: active work, last done, **next action**, blockers, environment quirks | every change | 60 lines |
| `memory/roadmap.md` | phases with checkboxes and definition of done | when a phase closes | 80 |
| `memory/phases/<n>-<name>.md` | task checklist of one phase | per task | 150 |
| `memory/changelog/YYYY-MM.md` | append-only, one line per change | append | per month |
| `memory/decisions/NNNN-title.md` | a decision, why, rejected alternative | never edited, superseded | 30 |
| `memory/architecture.md` | map of what exists, pinned versions | when structure changes | 100 |
{{TASKS_ROW}}
## Entry formats
- Changelog: `- 2026-01-05 · feat(scope) · what changed · <short sha> · proof (tests, lint)`. A `fix` line states the **root cause**.
- Task: `- [x] title (feat, done 2026-01-05, 3f9a1c2)` · `[~]` in progress · `[ ]` todo · `[!] blocked: reason`.
- Decision: title, date, status, context, decision, why, rejected alternatives.

## What to record
Only what code and `git log` cannot say: the **why**, the state, the traps, rejected approaches, unconfirmed assumptions. Never copy code. Never store secrets or personal data.

## Hygiene
When a cap is hit, compress; do not append. Before adding a line, check no other file holds it.

Good: `status.md` next action = "write the failing test for X in tests/Y, then implement Z".
Bad: next action = "continue the work".
