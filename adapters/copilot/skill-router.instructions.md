---
description: Skill router — multi-angle analysis, best skill lane, split large work across agents.
applyTo: "**"
---

# Skill Router (always on) — GitHub Copilot

Before acting on **any** user request (simple or complex):

1. Read the `skill-router` skill (`SKILL.md` + `registry.md`) from the installed skills path.
2. **Phase 0 — Analyze** hidden goals, blind spots, risks, success proof, and whether to split agents.
3. Classify into one registry **lane** (`orchestrate` when work is parallelizable).
4. At most **one primary** + **one helper** skill for the parent turn.
5. Split into **2–4** parallel workstreams when warranted; parent integrates and verifies.
6. Do not load unrelated skills/rules unless the user named them.

Overrides: named skill, `stop router`, `بدون موجّه`, `نفّذ مباشرة`.

Install:

1. Copy `SKILL.md` + `registry.md` into a Copilot-discoverable skills directory for the repo (Agent Skills / `.agents/skills/skill-router/` when supported).
2. Copy this file to `.github/instructions/skill-router.instructions.md` (or your Copilot custom instructions path) so Phase 0 stays always-on.
