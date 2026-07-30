---
name: skill-router
description: >-
  Always-on request orchestrator: analyze every user task from multiple angles,
  pick the best skill lane, and split large work across parallel agents. Use at
  the start of ANY user request (simple or complex); when routing skills; when
  the user mentions router, توجيه, تحليل الطلب, or تقسيم المهام.
license: MIT
compatibility: Cursor, Claude Code, Antigravity, Codex, Gemini CLI, OpenCode, Copilot
metadata:
  author: SaleemNijim
  version: "2.0.0"
---

# Skill Router

Orchestrator for every request: **think → analyze → route → (split if needed) → execute**.

Works with any Agent Skills–compatible harness (Cursor, Claude Code, Antigravity, Codex, Gemini CLI, OpenCode, and similar). Not a passive lane picker — force a multi-angle read before coding or answering, even when the ask looks trivial.

## Mandatory flow (every turn)

### Phase 0 — Multi-angle analysis (always, before tools)

Do this silently (or as a short internal checklist). Do **not** skip for "simple" tasks.

For the user request, answer:

1. **Surface ask** — What did they literally ask for?
2. **Hidden goals** — What outcome do they actually need? (shipping, data, UX, ownership, speed)
3. **Blind spots** — Angles they may not have considered (data integrity, auth/RLS, env mismatch, rollback, i18n/RTL, empty states, verification, cost/time, side effects on other apps)
4. **Risks** — What can go wrong if we do the naive thing?
5. **Success proof** — How will we know it worked? (query, screenshot, URL, test)
6. **Scope** — One agent enough, or split?

If a critical decision is ambiguous, ask **one** sharp question (with your recommended answer). Otherwise proceed.

Optional short user-facing lead-in (1–3 lines) when non-trivial:
`تحليل: … · مخاطر: … · تحقق: …`

### Phase 1 — Route

1. Classify into one lane from [registry.md](registry.md).
2. Activate **at most one primary** and **one optional helper**.
3. Read those skill files when needed; do **not** load excluded skills/rules.
4. Prefer no skill over the wrong skill.

### Phase 2 — Split (when warranted)

Split into **2–4 parallel agents** when **any** of these is true:

- Independent workstreams (e.g. DB seed + UI + deploy config)
- Exploration of 2+ separate code areas with no shared write lock
- Research / audit / review that can fan out
- Estimated effort > ~15 minutes of sequential tool use
- Multiple apps / packages in a monorepo affected

**Do not split** when:

- One file / one bug / one clarifying answer
- Steps are strictly sequential (B needs A's output)
- User said `بدون موجّه` / `stop router` / named a single skill only

#### How to split

1. Write a one-line goal + acceptance check per subtask.
2. Launch independent subagents in **parallel** (whatever your harness supports: Task tool, subagents, worktrees, etc.).
3. Keep the parent as integrator: merge results, resolve conflicts, run the success proof from Phase 0.
4. Each subagent gets: goal, paths, constraints, "do not touch X", and what to return.

### Phase 3 — Execute under the lane

Complete the work. Verify against Phase 0 success proof before claiming done.

## Caps

- Max 1 primary skill + 1 helper (skills)
- Max 4 parallel subagents per split wave
- Never activate registry **conflict pairs**
- Missing named skill → next best in-lane primary, or one short question

## Priority when ambiguous

1. User names a skill/plugin → honor it (still run Phase 0 analysis)
2. Clear registry triggers → that lane
3. Edited file stack → only stack-matched language rules
4. Else `general`, or one clarifying question

## always-on policy

- Keep a thin always-on rule that points at this skill (see harness adapters under `adapters/`)
- Heavy domain rules off unless the lane selects them
- Language packs only for the edited stack

## User override

- Named skill / plugin → use it
- `stop router` / `بدون موجّه` → skip routing + split for that turn (still think briefly)
- `نفّذ مباشرة` → skip long analysis; keep one-line risk check only

## Customization

Edit [registry.md](registry.md) to map lanes to skills installed in **your** environment.

## Maintainer note

When adding a skill to a project: append one registry row (triggers, primary, helper, excludes). Keep always-on rules thin; detail lives here.
