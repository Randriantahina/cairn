# Cairn: design

Working document. Everything here is a decision to confirm, not a promise.

## 1. Principles
1. **Rules, not rituals.** Markdown rules loaded automatically beat skills the user must remember to launch. One manual entry point only: `/cairn-init`.
2. **Few, short, checkable.** Under 50 lines per file. Each rule has a "good / not good" mini example. "Apply SOLID" is not a rule; "a repository contains queries only, business logic lives in a service" is.
3. **Proportional rigor.** The project size (small / medium / large) selects how many rules and how strict. DDD on a 5-table CRUD is a bug, not a feature.
4. **No drift.** Rules are generated from a config and can be re-synced against the real code.
5. **Honest enforcement.** Rules are advice. Real guarantees come from permissions and hooks, offered as opt-in tiers.
6. **Works for others.** No personal path, tool or language hard-coded. Every choice is a question with a sensible default.

## 2. What it generates
```
project/
├── AGENTS.md                      single source of truth for any agent (CLAUDE.md imports it)
├── CLAUDE.md                      short; imports AGENTS.md and points to .claude/
└── .claude/
    ├── cairn.json                 the answers: source of truth, makes re-runs deterministic
    ├── settings.json              (tier 1) permissions derived from the answers
    ├── rules/
    │   ├── process/               session protocol, tdd/testing, commits, branches, comments, ci
    │   └── stack/                 backend-<arch>.md, frontend-<structure>.md (path-scoped)
    ├── memory/                    status, roadmap, phases/, changelog/, decisions/, architecture
    ├── templates/                 memory skeletons
    └── hooks/                     (tier 2, opt-in) inject status at session start, guard commits
```
Memory is **split by lifespan** (a single progress file grows unreadable): `status` is rewritten every change and always read; `roadmap` and `phases/` hold checkboxes; `changelog/` is append-only per month; `decisions/` are written once.

## 3. Questions (detect first, ask only what is ambiguous)
Detection reads `composer.json`, `package.json`, lockfiles, `pubspec.yaml`, `Cargo.toml`, `go.mod`, folders. Questions come in **three short rounds**, each option has a recommended default, and every choice accepts **free text** ("other: ..."). A single "accept all defaults" shortcut exists.

**Round 1: project shape**
1. Layout: backend + frontend in one repo, separate repos, or one side only.
2. Stack (confirmed if detected).
3. Backend architecture: layered / DDD, hexagonal, MVC, "other (describe)".
4. Frontend structure: MVVM, feature slices, components-only, MVC, "other (describe)".
5. Size: small / medium / large (sets rigor).

**Round 2: tooling and git**
6. Package manager / build tool: detected from lockfile (`pnpm-lock.yaml`, `bun.lock`, `yarn.lock`, `package-lock.json`, `composer.lock`, `uv.lock`, `Cargo.lock`...). Choices: npm, pnpm, yarn, bun, other (free text). Generates the matching allow rules and **denies the others** to prevent drift.
7. Test runner and format/lint commands (detected, confirmed).
8. Git flow: trunk-based (`main` only), `dev` + `main`, GitHub Flow (feature branches + PR), git-flow, other (free text).
9. Commit convention: Conventional Commits / free / other; language of commit messages.
10. Push policy: never auto / push after green tests / ask each time.
11. CI present? (GitHub Actions, GitLab CI, none) and whether to generate a starter.

**Round 3: working mode**
12. Spec: with a spec (path; priority = spec, then rules, then judgment; on conflict stop and ask; spec items become checkboxes) or without (before each task ask at most three questions: goal, scope, done-criteria, and write them to `memory/tasks/`).
13. Language of the generated rules and memory (default English; any language).
14. Enforcement tier: 0 markdown only, 1 + permissions, 2 + hooks.

All answers are stored in `.claude/cairn.json`; re-running never re-asks what is already known.

## 4. Enforcement tiers
- **Tier 0**: markdown only. Safest, zero dependency.
- **Tier 1**: also writes `settings.json` permissions (allow the project's real commands, deny the other package managers, secrets, force-push).
- **Tier 2**: also installs two hooks proven in the reference project: inject `status.md` at session start; block a commit that carries no memory update. Needs bash and jq; documented limits on Windows.
Rationale: in practice the hooks are what made the discipline reliable, so they are opt-in, not absent.

## 5. Maintenance
- `/cairn-init` is re-runnable: generated sections are marked, user edits outside markers are kept, changes are shown as a diff before writing.
- `/cairn-sync`: compares rules and `architecture.md` with the real code and lists drift (dead paths, commands that no longer exist, layers that were never created).
- Versioned: `cairn.json` records the template version, so upgrades can propose a migration.

## 6. Testing the tool itself
- Presets are written for **one** case first (Laravel, layered). Others come after it is solid.
- Scenario suite: about ten prompts ("add an endpoint", "add a screen", "fix this bug") run on fixture projects; automated checks verify the produced diff respects the rules (test added first, commit format, no forbidden command used).
- Trial on three unlike projects (a Laravel app, a Flutter/Android app, a CLI) before publishing.

## 7. Roadmap
1. **MVP**: `/cairn-init` for Laravel + layered, tiers 0 and 1, memory split, process rules.
2. Smart detection and the three question rounds; `cairn.json`.
3. Spec / no-spec modes.
4. Re-run safely, `/cairn-sync`.
5. Tier 2 hooks, more presets (Node/Express, Vue/React, Flutter, Python), scenario suite, public release (MIT).

## 8. Open points to verify
- Whether Claude Code plugins can ship `rules/` directly. Assumption: no, so the init skill **writes** them into the project. Check the plugin docs before building the packaging.
- `AGENTS.md` import behaviour in Claude Code (`@AGENTS.md` from `CLAUDE.md`) and in Cursor/Codex.
- Hook portability (Windows) and whether to rewrite the two scripts in Node for a no-bash option.
- Names for the commands (`/cairn-init`, `/cairn-sync`) and whether the repo is a plugin marketplace or a plain template.

## 9. Reference implementation
The `.claude/` folder of the Écolio project (`rules/process`, `rules/stack`, `memory/`, `templates/`, `hooks/`, `commands/bootstrap-project.md`) is the working prototype; extract and generalise it rather than starting from zero.
