#!/usr/bin/env bash
# Cairn hook (SessionStart). Injecting the status is deterministic: a fresh session gets the
# project state even if it would otherwise skip reading it.
set -uo pipefail
ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"
MEM="$ROOT/.claude/memory"

[ -f "$MEM/status.md" ] || exit 0

echo "=== PROJECT MEMORY (injected by Cairn; protocol: .claude/rules/session-protocol.md) ==="
cat "$MEM/status.md"
[ -f "$MEM/roadmap.md" ] && { echo; cat "$MEM/roadmap.md"; }
echo "=== END PROJECT MEMORY: verify against git, then follow the session protocol ==="
