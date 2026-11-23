# Session protocol

The project's state lives in `.claude/memory/`, not in your head. A new session starts with zero context.

## Start of every session, before any code
1. Read `.claude/memory/status.md` and `roadmap.md` (a hook may already have injected them).
2. Run `git branch --show-current`, `git status --short`, `git log --oneline -5`.
3. If memory and git disagree, **git wins**: fix the memory first.
4. Tell the user in two lines: where the project stands, what you will do now.

## During the task
- Mark the task `[~]` in `status.md` before starting it.
- A blocker, trap or environment quirk goes into `status.md` the moment you learn it.

## After each finished change
Update the memory in the **same commit** as the change (see `memory.md`). A commit without it is incomplete.

## Never
- Start coding from a hunch left over from a previous conversation.
- Trust a status line you did not check against git.
- Leave memory edits uncommitted at the end of a task.

Good: "status says task 4 is done, but `git log` shows no such commit: fixing the status first."
Bad: continuing task 5 because the status said so.
