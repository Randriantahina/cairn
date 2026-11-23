# Cairn

> Stack the stones once, so every session finds the path.

Cairn sets up an AI-assisted project in one command: short, checkable **rules**, a small **project memory** (status, roadmap, decisions) and optional **guardrails**, tailored to your stack, your git flow and your tooling. Built for Claude Code first; the rules are plain markdown, so other agents can read them too.

**Status:** design phase. See [`DESIGN.md`](./DESIGN.md).

## Why the name
A cairn is a small stack of stones that hikers leave along a trail so the next person can find the way. That is exactly the job here: each session leaves rules, a status and a next action behind, so the next session (yours, a teammate's, an AI's) picks up the path instead of starting from zero. Stack the stones once, and the trail stays visible.

## Why
- A new session starts with zero context. Cairn gives it back from files, not from hope.
- Rules beat prompts you retype. But too many or too vague rules get ignored, so Cairn generates few, short, verifiable ones.
- The same method should work for a Laravel API, a Flutter app or a Rust CLI, at the rigor level you choose.

## Origin
Extracted from the `.claude/` folder of a real project (Écolio), where the method was proven: process rules, split project memory and two enforcement hooks.
