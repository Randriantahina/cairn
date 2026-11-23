# Placeholders

`/cairn:init` fills every `{{NAME}}` from `.claude/cairn.json` and the detection. Two groups: filled at init, and filled later by the user or the agent (skeletons copied to `.claude/templates/`, which the final `{{` check skips).

## Filled at init
| Placeholder | Source | Example |
|---|---|---|
| `PROJECT_SUMMARY` | spec or one question | `Laravel 12 API for school billing.` |
| `COMMANDS_BLOCK` | detected scripts, confirmed | bullet list: install, test, lint, build |
| `PRIORITY_BLOCK` | spec mode: spec > rules > judgment, stop on conflict. Ask mode: ask at most 3 questions per task | |
| `PACKAGE_MANAGER` | lockfile, confirmed | `pnpm` |
| `BACKEND_STACK` / `FRONTEND_STACK` | manifests | `Laravel 12` / `Vue 3` |
| `BACKEND_PATH` / `FRONTEND_PATH` | layout detection; `app/`, `backend/`, empty at root | `backend/` |
| `MAIN_BRANCH` / `DEV_BRANCH` / `WORK_BRANCH` | git flow answer, `git branch` | `main` / `dev` / `dev` |
| `PUSH_STEP` | push policy, one line | `Push after green gates.` |
| `PUSH_DONE_LINE` | push policy, one DoD line | `- [ ] Pushed to origin.` or empty |
| `TEST_APPROACH` | `TDD` or `Tests with the change` | |
| `TEST_COMMAND` / `TEST_ONE_COMMAND` | detected | `php artisan test` / `php artisan test --filter=Name` |
| `GATE_COMMANDS` | test + lint + static analysis, joined | `` `composer test`, `composer lint` `` |
| `TDD_BLOCK` | TDD steps, or empty when not TDD | |
| `COMMIT_LANGUAGE` / `COMMENT_LANGUAGE` | language answer | `English` |
| `STACK_LINES` | one line per detected layer | `- Backend: Laravel 12 (app/)` |
| `TASKS_ROW` | spec mode: path to tasks; ask mode: `.claude/memory/tasks/` | |
| `ROADMAP_ITEMS` | spec items as `- [ ]`, or empty | |
| `FIRST_ACTION` | first roadmap item or "define the first phase" | |
| `HOOKS_NOTE` | `, hooks` at level 2, otherwise empty | |
| `PHP_VERSION` / `NODE_VERSION` | `composer.json` require / `.nvmrc` or `engines`, else ask | `8.3` / `20` |
| `INSTALL_COMMAND` / `LINT_COMMAND` | package manager's frozen install, detected lint | `pnpm install --frozen-lockfile` |
| `DATE` | today, `YYYY-MM-DD` | |

## Filled later (skeletons in `.claude/templates/`)
`NNNN`, `TITLE` (decision, task), `N`, `NAME`, `GOAL`, `DOD` (phase), `ID` (task).

## Rules
- An empty value removes its whole line, never leaves a blank bullet.
- A placeholder with no answer and no default is a question, not a guess.
