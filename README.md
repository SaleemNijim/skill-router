# Skill Router

**Think first. Pick one skill. Split when the work is big.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-SKILL.md-black)](https://agentskills.io)
[![Routing suite](https://img.shields.io/badge/routing%20suite-20%20cases-success)](tests/routing-cases.md)
[![Composite](https://img.shields.io/badge/composite-95%25-brightgreen)](metrics.md)

Skill Router is a portable Agent Skill for coding agents. On every request — simple or complex — it:

1. **Analyzes** the ask from angles you may not have considered (hidden goals, risks, verification)
2. **Routes** to at most **one primary** skill + **one optional helper**
3. **Splits** large / parallel work across **2–4 agents**, then integrates and verifies

Built for **Cursor**, **Claude Code**, **Google Antigravity**, **Codex**, **Gemini CLI**, **OpenCode**, **GitHub Copilot**, and any tool that follows the [Agent Skills](https://agentskills.io) / `SKILL.md` standard.

> Arabic triggers work too: `توجيه`, `هل فهمتني`, `بدون موجّه`, `نفّذ مباشرة`, `قسّم`.

## Why

When many skills and rules are installed, agents mix them: design packs fight minimal-code packs, five language rules load for a one-file fix, and “simple” tasks skip thinking.

Skill Router is the traffic controller: **analyze → route → (orchestrate) → execute**.

Measured on a fixed 20-case suite: see [`metrics.md`](metrics.md) and [`tests/routing-cases.md`](tests/routing-cases.md).

## Quick install

### Skills CLI (works across many harnesses)

```bash
npx skills add SaleemNijim/skill-router -g -y
```

Project-local:

```bash
npx skills add SaleemNijim/skill-router -y
```

### Install script (multi-target)

```bash
git clone https://github.com/SaleemNijim/skill-router.git
cd skill-router

# macOS / Linux
chmod +x install.sh
./install.sh all global          # Cursor + Claude + Antigravity + ~/.agents
./install.sh cursor project      # current repo only
./install.sh claude global
./install.sh antigravity global
```

```powershell
# Windows (PowerShell)
git clone https://github.com/SaleemNijim/skill-router.git
cd skill-router
.\install.ps1 -Target all
.\install.ps1 -Target cursor -Project
.\install.ps1 -Target antigravity
```

Then **reload** the agent / IDE session.

---

## Install by AI tool

### Cursor

| Piece | Personal (global) | Project |
|-------|-------------------|---------|
| Skill | `~/.cursor/skills/skill-router/` | `.cursor/skills/skill-router/` |
| Always-on rule | `~/.cursor/rules/skill-router.mdc` | `.cursor/rules/skill-router.mdc` |

Copy `SKILL.md` + `registry.md` into the skill folder, and `.cursor/rules/skill-router.mdc` into rules (`alwaysApply: true`).

Turn **off** `alwaysApply` on heavy domain rules (e.g. global minimal-code). Let the router enable them per lane.

### Claude Code

| Piece | Personal | Project |
|-------|----------|---------|
| Skill | `~/.claude/skills/skill-router/` | `.claude/skills/skill-router/` |
| Always-on rule | `~/.claude/rules/skill-router.md` | `.claude/rules/skill-router.md` |

Use [`adapters/claude/skill-router.md`](adapters/claude/skill-router.md).

### Google Antigravity

| Scope | Path |
|-------|------|
| Project | `<workspace>/.agents/skills/skill-router/` |
| Global | `~/.gemini/config/skills/skill-router/` |

Details: [`adapters/antigravity/README.md`](adapters/antigravity/README.md).

### OpenAI Codex

1. Install the skill (`npx skills add … -g` or project `.agents/skills/`).
2. Paste [`adapters/codex/AGENTS.snippet.md`](adapters/codex/AGENTS.snippet.md) into `AGENTS.md`.

### Gemini CLI

- Skill paths + always-on: [`adapters/gemini-cli/skill-router.md`](adapters/gemini-cli/skill-router.md)
- Prefer `~/.gemini/config/skills/skill-router/` for global discovery

### OpenCode

- Always-on + paths: [`adapters/opencode/skill-router.md`](adapters/opencode/skill-router.md)

### GitHub Copilot

- Instructions file: [`adapters/copilot/skill-router.instructions.md`](adapters/copilot/skill-router.instructions.md) → typically `.github/instructions/`
- Skill body still lives as `SKILL.md` + `registry.md` under your Copilot skills / `.agents/skills/` path

---

## How it works

```text
User request
  → Phase 0: multi-angle analysis (goals, blind spots, risks, proof, scope)
  → Phase 1: classify lane → primary (+ optional helper)
  → Phase 2: split 2–4 agents if warranted
  → Phase 3: execute + verify success proof
```

| Lane | Intent |
|------|--------|
| `design-ui` | Visual / frontend design |
| `minimal-code` | YAGNI / smallest correct change |
| `docs` | Documentation |
| `debug` | Root-cause debugging |
| `implement` | Feature work |
| `review` | Code / PR review |
| `plan` | Architecture / grilling before build |
| `orchestrate` | Large / multi-stream work → split agents |
| `meta-skills` | Authoring skills/rules |
| `general` | Q&A — load nothing |

Full mapping, **negative triggers**, conflict pairs: [registry.md](registry.md).  
Agent instructions + examples: [SKILL.md](SKILL.md).

## Real output

Example user ask: **«صمّملي dashboard»**

```text
تحليل: لوحة تحكم تحتاج هيكل معلومات + UI؛ غالباً بيانات وهمية أولاً
مخاطر: تجاهل RTL / تكديس كروت بدون مهمة واضحة لكل قسم
تحقق: screenshot لـ desktop + mobile بعد ما الـ mock data تظهر

Lane: design-ui
Primary: frontend-design
Helper: ponytail
Split: نعم — أجنت UI · أجنت mock data (حد أقصى 2 هنا)
```

Override example: **«نفّذ مباشرة: زِد الـ timeout إلى 30s»** → short risk line only, no grilling, no split.

## Comparison

Honest overlap — different tools solve different layers. Pick what matches your stack.

| Feature | SaleemNijim/skill-router | [erichare/skill-route](https://github.com/erichare/skill-route) | [hussi9/skill-router](https://github.com/hussi9/skill-router) |
|---------|--------------------------|------------------------------------------------------------------|----------------------------------------------------------------|
| Approach | Instruction skill + registry lanes | Semantic catalog / MCP / SQLite | Claude Code triage + model/thinking chain |
| Arabic triggers | ✅ first-class | ❌ | ❌ |
| Multi-harness adapters | ✅ Cursor, Claude, Antigravity, Codex, Gemini CLI, OpenCode, Copilot | ✅ many MCP clients | ❌ Claude-first (Codex draft) |
| Agent splitting | ✅ Phase 2 / `orchestrate` | ❌ (ranking, not split execution) | ✅ multi-domain chains |
| Negative triggers | ✅ `Must NOT trigger on` | via evals/metadata | pattern tables in skill |
| Published test suite | ✅ 20 cases + [metrics](metrics.md) | golden-route evals in tooling | ✅ 20-prompt harness (~90% path) |
| Install weight | Copy markdown / `npx skills` | Python + optional UI/MCP | curl one `SKILL.md` |
| Best when | You want bilingual, portable always-on discipline | You need searchable routing over huge skill libraries | You live in Claude Code and want model/chain announcements |

## Customize

Edit `registry.md` so **Primary** / **Helper** match skills you actually installed. Defaults mention popular skills (`frontend-design`, `ponytail`, `karpathy-guidelines`, …) only as examples when present — the router must not invent installs.

## Companion skills (optional)

Not required. Wire them in your registry if you use them:

- [frontend-design](https://skills.sh/) — distinctive UI
- [ponytail](https://github.com/DietrichGebert/ponytail) — minimal correct code
- [andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) — think / surgical changes
- [grill-me](https://github.com/mattpocock/skills) — stress-test the plan before coding

## Overrides

| Phrase | Effect |
|--------|--------|
| Name a skill explicitly | Router yields (Phase 0 still runs briefly) |
| `stop router` / `بدون موجّه` | Skip auto-routing + split for that turn |
| `نفّذ مباشرة` | Skip long analysis; keep a one-line risk check |

## Layout

```text
.
├── SKILL.md                         # portable Agent Skill
├── registry.md                      # lanes + negative triggers
├── tests/routing-cases.md           # 20 routing cases
├── metrics.md                       # scores + how to run
├── CHANGELOG.md
├── CONTRIBUTING.md
├── .cursor/rules/skill-router.mdc
├── adapters/
│   ├── claude/
│   ├── antigravity/
│   ├── codex/
│   ├── gemini-cli/
│   ├── opencode/
│   └── copilot/
├── install.sh / install.ps1
├── README.md
└── LICENSE
```

## Verify

Ask the agent: “Design a landing page” or “Migrate this DB and update three apps.”

You should see: short analysis (when non-trivial) → one lane → at most two skills → optional agent split → verification before “done”.

Or run the suite in [`tests/routing-cases.md`](tests/routing-cases.md) and compare to [`metrics.md`](metrics.md).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). PRs that add English triggers must include Arabic counterparts.

## License

[MIT](LICENSE) — © 2026 Saleem Nijim
