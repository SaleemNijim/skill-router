# Skill Router

**Think first. Pick one skill. Split when the work is big.**

Skill Router is a portable Agent Skill for coding agents. On every request — simple or complex — it:

1. **Analyzes** the ask from angles you may not have considered (hidden goals, risks, verification)
2. **Routes** to at most **one primary** skill + **one optional helper**
3. **Splits** large / parallel work across **2–4 agents**, then integrates and verifies

Built for **Cursor**, **Claude Code**, **Google Antigravity**, **Codex**, **Gemini CLI**, **OpenCode**, and any tool that follows the [Agent Skills](https://agentskills.io) / `SKILL.md` standard.

> Arabic triggers work too: `توجيه`, `هل فهمتني`, `بدون موجّه`, `نفّذ مباشرة`, `قسّم`.

## Why

When many skills and rules are installed, agents mix them: design packs fight minimal-code packs, five language rules load for a one-file fix, and “simple” tasks skip thinking.

Skill Router is the traffic controller: **analyze → route → (orchestrate) → execute**.

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

Use the file in [`adapters/claude/skill-router.md`](adapters/claude/skill-router.md).

Plugin-style install also works if you mirror this repo into a Claude marketplace plugin later; the skill body is the same `SKILL.md`.

### Google Antigravity (and Gemini surfaces)

| Scope | Path |
|-------|------|
| Project | `<workspace>/.agents/skills/skill-router/` |
| Global (best cross-surface default) | `~/.gemini/config/skills/skill-router/` |

Details: [`adapters/antigravity/README.md`](adapters/antigravity/README.md).

Copy `SKILL.md` + `registry.md` into that folder. Prefer real directories (not broken symlinks). Absolute custom skill paths are more reliable than `~` in some Antigravity IDE builds.

### OpenAI Codex

1. Install the skill into a path Codex discovers (often via `npx skills add … -g`, or project `.agents/skills/`).
2. Paste the short block from [`adapters/codex/AGENTS.snippet.md`](adapters/codex/AGENTS.snippet.md) into project `AGENTS.md` (or your global Codex instructions) so Phase 0 stays always-on.

### Gemini CLI / OpenCode / Copilot / others

If the tool supports Agent Skills:

1. Put `SKILL.md` + `registry.md` in that tool’s skills directory (commonly `~/.agents/skills/skill-router/` or `<project>/.agents/skills/skill-router/`).
2. Add a one-line always-on instruction: *“Follow skill-router before every task.”*

Same skill file — different discovery folders.

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

Full mapping, conflict pairs, overrides: [registry.md](registry.md).  
Full agent instructions: [SKILL.md](SKILL.md).

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
├── SKILL.md                         # portable Agent Skill (repo root for npx skills)
├── registry.md                      # lane → skill map
├── .cursor/rules/skill-router.mdc   # Cursor always-on
├── adapters/
│   ├── claude/skill-router.md       # Claude Code rule
│   ├── antigravity/README.md        # Antigravity paths
│   └── codex/AGENTS.snippet.md      # Codex / AGENTS.md snippet
├── install.sh / install.ps1         # multi-harness installers
├── README.md
└── LICENSE
```

## Verify

Ask the agent: “Design a landing page” or “Migrate this DB and update three apps.”

You should see: short analysis (when non-trivial) → one lane → at most two skills → optional agent split → verification before “done”.

## License

[MIT](LICENSE) — © 2026 Saleem Nijim
