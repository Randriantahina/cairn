---
name: sync
description: Compare the project's Cairn rules, memory and architecture.md with the real code and list the drift (dead paths, vanished commands, layers never created). Read-only.
disable-model-invocation: true
---

# /cairn:sync

Read-only audit. It reports; it never edits. Fixes go through `/cairn:init` (update mode) or the user.

## Preconditions
`.claude/cairn.json` must exist. If not, say so and point to `/cairn:init`.

## Checks
Run each against the real repository and record every mismatch with the file and line that makes the claim.

1. **Dead paths**: every path named in `.claude/rules/*.md`, `AGENTS.md` and `.claude/memory/architecture.md` (including `paths:` globs in frontmatter) must match at least one existing file.
2. **Vanished commands**: every command in `AGENTS.md` and `cairn.json` (install, test, lint, build) must still exist: script in `package.json`/`composer.json`, Makefile target, or binary on the PATH. Do not execute them; look them up.
3. **Layers never created**: each layer or folder the architecture rule requires (domain, application, infrastructure, interface, viewmodels...) must exist in the code. Report absent ones, and the opposite: top-level code folders the architecture does not mention.
4. **Rule violations**: the "Checkable" lines of the architecture rule, searched with grep (for example an ORM import inside the domain folder). List hits, do not judge intent.
5. **Config vs reality**: package manager in `cairn.json` against the lockfile present; git flow against existing branches; permissions in `settings.json` against the chosen package manager.
6. **Memory vs git**: `status.md` claims against `git log` and `git status`; roadmap items marked done with no matching commit.
7. **Hygiene**: any rule file over 50 lines, leftover `{{`, hooks listed in `settings.json` that are missing or not executable.

## Report
One table per check that found something: `where | what the file claims | what the code shows`. End with a count per check and, for each finding, the suggested action: edit the rule, create the layer, or update `cairn.json`. If nothing is found, say so in one line. Never claim a check passed that you did not run; name any check you had to skip and why.
