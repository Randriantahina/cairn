---
name: init
description: Set up (or update) Cairn in the current project - short checkable rules, split project memory, AGENTS.md/CLAUDE.md and optional permissions and hooks, tailored to the detected stack.
disable-model-invocation: true
---

# /cairn:init

Templates live in `${CLAUDE_PLUGIN_ROOT}/templates/`. A plugin cannot ship `rules/`, so this skill **writes** everything into the user's project. Never write outside the project. Placeholders are listed in `${CLAUDE_PLUGIN_ROOT}/templates/PLACEHOLDERS.md`.

## 0. Mode
- `.claude/cairn.json` exists: **update mode** (see section 7). Never re-ask a question already answered in it.
- Otherwise: **first run**. Continue below.

## 1. Detect (read-only, ask nothing yet)
Collect: lockfiles and manifests (`composer.json`, `package.json`, `pubspec.yaml`, `Cargo.toml`, `go.mod`, `pyproject.toml`), top-level folders (`app/`, `src/`, `lib/`, `frontend/`, `backend/`), `git branch -a`, `.github/workflows`, existing `.claude/`, `AGENTS.md`, `CLAUDE.md`, and the size signal (file count, number of models/tables).
Summarise what was found in 3 lines. A detected value becomes the recommended default; do not ask about it unless it is ambiguous.

**Layout (same folder or not).** Look for one manifest at the root, or several in sub-folders (`backend/composer.json` + `frontend/package.json`, `apps/*`, `packages/*`). Classify each manifest as backend or frontend by its dependencies (laravel, express, django = backend; react, vue, flutter, svelte = frontend).
- One manifest at root: single-side project; `{{BACKEND_PATH}}` or `{{FRONTEND_PATH}}` is empty.
- Backend and frontend manifests in one repo: monorepo. Record each path (`backend/`, `frontend/`) in `cairn.json`; the architecture rules are path-scoped to them, each with its own package manager and commands.
- Same manifest holds both (Laravel + Inertia/Vue, Next.js): one root, two path-scoped rules (`app/`, `resources/js/`).
Ask only if the classification is unclear.

**Spec.** Look for `SPEC.md`, `PRD.md`, `docs/spec*`, `specs/`, `openapi.*`, `requirements*`, or a spec path in `README.md`.
- **Spec found: spec mode.** Read it and derive every answer it settles (stack, architecture, size, scope, language). Ask only what it leaves open, and the questions it cannot answer (git flow, push policy, level). Spec items become checkboxes in `roadmap.md`. Priority: spec, then rules, then judgment; on conflict stop and ask.
- **No spec: ask mode.** Run the rounds below. Add to `AGENTS.md` that, before each task, the agent asks at most three questions (goal, scope, done-criteria) and writes the answers to `.claude/memory/tasks/`.

## 2. Questions: 3 rounds maximum
Use AskUserQuestion. Each question: recommended option first and marked "(Recommended)", free text always possible via "Other". Skip any question already settled by detection. A first option "Accept all defaults" ends the rounds early.

- **Round 1, shape**: layout (one repo / separate / one side), stack, backend architecture, frontend structure, size (small / medium / large).
- **Round 2, tooling and git**: package manager, test and lint commands, git flow (trunk / dev+main / GitHub Flow / git-flow), commit convention and commit language, push policy (never auto / after green tests / ask), CI (none / GitHub Actions / GitLab CI; offer a starter).
- **Round 3, working mode**: language of rules and memory, enforcement level (0 markdown, 1 + permissions, 2 + hooks).

Proportional rigor: small project means simple-layered and a lean rule set; DDD is offered only for medium and large. Never recommend more than the size justifies.

## 3. Plan, then confirm
Before any write, print the plan: every file to create or change, the level, the answers. For each existing file, show a diff of what would change. Ask one confirmation. No write happens before a yes.

## 4. Write
Order: `cairn.json`, memory, rules, `AGENTS.md`, `CLAUDE.md`, then level 1 and 2 files. Fill every `{{...}}` from the answers. Keep each file under 50 lines.

- `.claude/cairn.json`: all answers plus `"cairnVersion"` (from `plugin.json`) and `"level"`.
- `.claude/memory/`: `status.md`, `roadmap.md`, `architecture.md` from `templates/memory/`; copy `phase.md`, `decision.md`, `task.md` to `.claude/templates/` as skeletons.
- `.claude/rules/` (flat): `core/*` as `<name>.md`; the chosen `git/` flow plus `commits-conventional.md`; the chosen backend and frontend architecture as `backend.md` and `frontend.md`.- `AGENTS.md` and `CLAUDE.md`: from the templates. `CLAUDE.md` only imports `@AGENTS.md`.
- Level 1: `.claude/settings.json` `permissions`, built from `templates/permissions/`. Start from `base.json` (apply the `pushPolicy` entry matching the answer, then drop the `pushPolicy` key), add the chosen manager's `allow` from `package-managers.json`, and add `Bash(<name> *)` to deny for every other manager of the same ecosystem. Add the detected test and lint commands to allow. In a monorepo, do this per side. Strip all `_comment` keys.
- Level 2: copy `templates/hooks/*.sh` to `.claude/hooks/`, `chmod +x`, and register in `.claude/settings.json`: `SessionStart` runs `session-start.sh`; `PreToolUse` with matcher `Bash` runs `guard-commit.sh`, both via `"$CLAUDE_PROJECT_DIR/.claude/hooks/..."`. Copied, not referenced from the plugin, so the project stays self-contained. State in the summary that hooks need bash and jq and fail open without jq.
- CI starter only if asked and GitHub Actions: `templates/ci/github-actions-laravel.yml` or `-node.yml` to `.github/workflows/ci.yml`. Never overwrite an existing workflow; for another stack or GitLab CI, write one by the same pattern (checkout, setup, install, lint, test) and say it is a draft.

## 5. Markers and existing files
Generated blocks sit between `<!-- cairn:start -->` and `<!-- cairn:end -->`. Replace only what is inside; never touch the rest. A file without markers that already exists: show the diff and ask before changing it. For `settings.json`, merge (keep the user's keys, union permission lists); never overwrite.

## 6. Verify
Run these checks and report each result honestly:
1. `grep -rn '{{' AGENTS.md CLAUDE.md .claude/ --exclude-dir=templates` finds nothing (skeletons in `.claude/templates/` keep theirs).
2. Every `.claude/rules/*.md` has at most 50 lines (`wc -l`).
3. `.claude/cairn.json` and `.claude/settings.json` parse (`jq empty`, or `python3 -m json.tool`).
4. Level 2: hooks are executable and `bash -n` passes on each.
Fix and re-check on failure. Finish with the file list and one suggested first task.

## 7. Update mode
Read `cairn.json`. Compare its `cairnVersion` with the plugin's. Re-render from the stored answers, show a diff per file, and write only what the user accepts. Ask only about what is new (a field absent from `cairn.json`). Changing an answer: update `cairn.json` first, then re-render. Suggest `/cairn:sync` afterwards.
