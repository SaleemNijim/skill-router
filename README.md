# Skill Router

**One primary skill. One optional helper. No skill soup.**

Skill Router is a small always-on controller for AI coding agents (Cursor and friends). It classifies each request into a **lane**, activates at most two skills, and keeps the rest out of the way.

Use it when you have many skills/rules installed and they start contradicting each other — design packs fighting minimal-code packs, or five language rule sets loading for a one-file fix.

## Install

### Skills CLI (recommended)

```bash
npx skills add SaleemNijim/skill-router -g -y
```

Or project-local:

```bash
npx skills add SaleemNijim/skill-router -y
```

### Cursor (manual)

1. Copy `SKILL.md` + `registry.md` into:
   - Personal: `~/.cursor/skills/skill-router/`
   - Or project: `.cursor/skills/skill-router/`
2. Copy `.cursor/rules/skill-router.mdc` into the same scope's `.cursor/rules/` (set `alwaysApply: true`).
3. Turn **off** `alwaysApply` on heavy domain rules (for example a global minimal-code rule). Let the router enable them per lane.

### Verify

Ask the agent something like: “Design a landing page” or “Fix this bug with the smallest diff.”  
You should see lane discipline (optional one-liner: `lane: … · primary: … · helper: …`) and no pile-on of unrelated skills.

## How it works

```text
user request
    → classify lane (registry.md)
    → primary (+ optional helper)
    → ignore excludes / conflict pairs
    → do the work
```

| Lane | Intent |
|------|--------|
| `design-ui` | Visual / frontend design |
| `minimal-code` | YAGNI / smallest correct change |
| `docs` | Documentation |
| `debug` | Root-cause debugging |
| `implement` | Feature work |
| `review` | Code / PR review |
| `plan` | Architecture / approach |
| `meta-skills` | Authoring skills/rules |
| `general` | Q&A — load nothing |

Full mapping, conflict pairs, and overrides: [registry.md](registry.md). Agent instructions: [SKILL.md](SKILL.md).

## Customize

Edit `registry.md` so **Primary** / **Helper** match skills you actually installed. Defaults mention popular skills (`frontend-design`, `ponytail`, …) only as examples when present — the router must not invent installs.

## Companion skills (optional)

These are **not** required. Wire them in your registry if you use them:

- [frontend-design](https://skills.sh/) — distinctive UI direction
- [ponytail](https://github.com/DietrichGebert/ponytail) — minimal correct code

## Overrides

- Name a skill explicitly → router yields
- `stop router` / `بدون موجّه` → skip auto-routing for that turn

## Layout

```text
.
├── SKILL.md                      # agent skill (discoverable at repo root)
├── registry.md                   # lane → skill map
├── .cursor/rules/skill-router.mdc
├── README.md
└── LICENSE
```

Compatible with `npx skills add` discovery (root `SKILL.md`).

## License

[MIT](LICENSE)
