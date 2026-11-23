# Cairn

> Stack the stones once, so every session finds the path.

Cairn sets up an AI-assisted project in one command: short, checkable **rules**, a small **project memory** (status, roadmap, decisions) and optional **guardrails**, tailored to your stack, your git flow and your tooling. Built for Claude Code first; the rules are plain markdown, so other agents can read them too.

**Status:** first version written, not yet tested on real projects. See [`DESIGN.md`](./DESIGN.md).

## Install
In Claude Code:
```
/plugin marketplace add Randriantahina/cairn
/plugin install cairn@cairn
/cairn:init
```

## Use
- `/cairn:init` detects your stack, layout (one side, monorepo, or both in one manifest) and spec. With a spec it fills in the answers it can and asks the rest; without one it asks, in at most three short rounds, each with a recommended default and free text. It shows a plan and diffs before writing anything.
- Run it again any time: answers are kept in `.claude/cairn.json`, generated blocks sit between `<!-- cairn:start -->` and `<!-- cairn:end -->`, and everything outside them is never touched.
- `/cairn:sync` lists drift between the rules and the real code (dead paths, vanished commands, layers never created). It only reports.

## Enforcement levels
| Level | Adds | Needs |
|---|---|---|
| 0 | markdown rules and memory only | nothing |
| 1 | `settings.json` permissions: your package manager allowed, the others denied, secrets and force-push denied | nothing |
| 2 | hooks: inject `status.md` at session start, block a commit with no `.claude/memory/` update | bash, jq (they fail open without jq) |

## What gets written
`AGENTS.md` (single source, `CLAUDE.md` imports it), `.claude/cairn.json`, `.claude/rules/*.md` (under 50 lines each, with a good / bad example), `.claude/memory/` split by lifespan, and at levels 1 and 2 `.claude/settings.json` and `.claude/hooks/`.

## License
MIT, see [`LICENSE`](./LICENSE). Changes: [`CHANGELOG.md`](./CHANGELOG.md).

## Why the name
A cairn is a small stack of stones that hikers leave along a trail so the next person can find the way. That is exactly the job here: each session leaves rules, a status and a next action behind, so the next session (yours, a teammate's, an AI's) picks up the path instead of starting from zero. Stack the stones once, and the trail stays visible.

## Why
- A new session starts with zero context. Cairn gives it back from files, not from hope.
- Rules beat prompts you retype. But too many or too vague rules get ignored, so Cairn generates few, short, verifiable ones.
- The same method should work for a Laravel API, a Flutter app or a Rust CLI, at the rigor level you choose.

## Origin
Extracted from the `.claude/` folder of a real project (Écolio), where the method was proven: process rules, split project memory and two enforcement hooks.
