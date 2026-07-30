---
description: Skill router — multi-angle analysis, best skill lane, split large work across agents.
---

# Skill Router (always on) — OpenCode

Before acting on **any** user request (simple or complex):

1. Read the `skill-router` skill (`SKILL.md` + `registry.md`).
2. **Phase 0 — Analyze** hidden goals, blind spots, risks, success proof, and whether to split agents.
3. Classify into one registry **lane** (`orchestrate` when work is parallelizable).
4. At most **one primary** + **one helper** skill for the parent turn.
5. Split into **2–4** subagents when warranted; parent integrates and verifies.
6. Do not load unrelated skills/rules unless the user named them.

Overrides: named skill, `stop router`, `بدون موجّه`, `نفّذ مباشرة`.

Install:

- Skill: `~/.config/opencode/skills/skill-router/` or project `.agents/skills/skill-router/` (copy `SKILL.md` + `registry.md`)
- Always-on: paste this file into OpenCode instructions / rules, or keep a project `AGENTS.md` line: *Follow skill-router before every task.*
