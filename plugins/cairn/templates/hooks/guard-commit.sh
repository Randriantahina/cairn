#!/usr/bin/env bash
# Cairn hook (PreToolUse, Bash). A commit must carry a project-memory update.
# Exit 2 blocks the call and shows stderr to the agent so it can fix and retry.
# Degrades open: without jq or git we allow, because a broken guard must never lock the user out.
set -uo pipefail

command -v jq >/dev/null 2>&1 || exit 0
input="$(cat)"
cmd="$(printf '%s' "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)"
[ -n "$cmd" ] || exit 0

# Only real commits; amend reuses the previous commit's content.
printf '%s' "$cmd" | grep -Eq '(^|[;&| ])(rtk )?git( -C [^ ]+)? commit' || exit 0
printf '%s' "$cmd" | grep -q -- '--amend' && exit 0

# Judge the repository the commit happens in (the tool's cwd), not the folder Claude was launched
# from: a side repo opened from another project must not be checked against that project's memory.
cwd="$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)"
target="$(printf '%s' "$cmd" | sed -nE 's/.*git -C ([^ ]+) commit.*/\1/p')"
cd "${target:-${cwd:-${CLAUDE_PROJECT_DIR:-.}}}" 2>/dev/null || exit 0
root="$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0

# Repos that did not opt in (no memory folder) are not our business.
[ -d "$root/.claude/memory" ] || exit 0

if printf '%s' "$cmd" | grep -Eq 'git( -C [^ ]+)? add'; then
  # Staging happens inside the same command: the index is not final yet, look at the worktree.
  changed="$(git -C "$root" status --porcelain -- .claude/memory 2>/dev/null)"
else
  changed="$(git -C "$root" diff --cached --name-only -- .claude/memory 2>/dev/null)"
fi

if [ -z "$changed" ]; then
  cat >&2 <<'MSG'
Commit blocked by Cairn: no change under .claude/memory/ is included.
Update in the same commit: the task checklist, one changelog line, and status.md (next action).
Do the memory edit in its own step first, then commit. See .claude/rules/memory.md.
MSG
  exit 2
fi
exit 0
