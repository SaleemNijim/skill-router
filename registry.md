# Skill Router Registry

After **Phase 0 analysis** (see SKILL.md), pick **one primary**. Add **at most one helper** if useful. Ignore everything else for that turn unless the user names it.

> **Customize:** replace primary/helper names with skills installed in your environment. Defaults below are examples — do not invent missing installs.

## Lanes

| Lane | Triggers | Must NOT trigger on | Primary | Helper (optional) | Hard excludes |
|------|----------|---------------------|---------|-------------------|---------------|
| `design-ui` | UI, landing page, frontend design, visual identity, typography, layout / تصميم، واجهة، صفحة هبوط | "fix the CSS bug" (→ `debug`); "document the design system" (→ `docs`); "review the UI PR" (→ `review`) | `frontend-design` (if installed) else design guidance without extra packs | `ponytail` | Competing design systems; unrelated language packs; security/review skills |
| `minimal-code` | simplest, YAGNI, lazy, less code, over-engineering / أبسط حل، تقليل كود | "design a minimalist landing page" (→ `design-ui`); full feature builds that need architecture (→ `plan` / `implement`) | `ponytail` (if installed) else minimal-diff discipline | `karpathy-guidelines` | Scaffolding generators; unsolicited abstractions |
| `docs` | docs, README, changelog, documentation / توثيق | "document then implement the feature" when code is the real ask (→ `implement` after short docs note); redesign requests (→ `design-ui`) | project docs skill if any, else write docs directly | `ponytail` | Design-only skills |
| `debug` | bug, broken, error, fails, investigate / خطأ، ما بيشتغل | "add error handling as a new feature" with no failing behavior (→ `implement`); pure "what is X?" questions (→ `general`) | `systematic-debugging` (if installed) else root-cause debug workflow | `karpathy-guidelines` | Design skills; unsolicited refactors |
| `implement` | add feature, build, implement / نفّذ، أضف ميزة | "نفّذ مباشرة" tiny one-liners still OK here but skip long plan; multi-app migrate/deploy bundles (→ `orchestrate`); "هل فهمتني" before build (→ `plan`) | stack-matched coding skill/rule only if needed | `karpathy-guidelines` or `ponytail` | Unrelated language packs; design skills unless UI is in scope |
| `review` | review PR, code review / مراجعة | "write the feature then review" when no diff exists yet (→ `implement`); design critique of a blank page (→ `design-ui` / `plan`) | code-review skill or subagent if available | — | Design-only skills |
| `plan` | plan, architecture, tradeoffs, grill, هل فهمتني / خطّة، تصميم معماري | "just fix the typo" (→ skip / implement); user said `نفّذ مباشرة` (→ short path) | `grill-me` or `grilling` or brainstorming skill | `karpathy-guidelines` | Jumping straight to implementation skills |
| `meta-skills` | add skill, router, registry, install plugin, handoff / سكيل، موجّه | App feature work that merely mentions "skill" in product copy (→ `implement`) | `skill-router` + skill/rule authoring tools | `handoff` | Unrelated domain skills |
| `orchestrate` | multi-app, migrate, deploy+seed, large refactor, "كل شيء", split work / قسّم، وكلاء | Single-file bugfix (→ `debug`); one-component UI tweak (→ `design-ui` / `implement`) | Phase 0 + Phase 2 split; per-subtask lane from this table | `handoff` if context is long | Loading every skill at once |
| `general` | Q&A, explanation, no code change | Any request that clearly asks to edit code, deploy, or design a screen | — (no skill) | — | Don't load coding/design skills |

## Conflict pairs (never co-activate)

- Two competing design authorities as peers
- Multiple unrelated language rule packs in one turn — pick the stack you are editing
- Ultra-minimal / delete-first mode + expansive scaffolding or coverage-max skills
- Deep review mode + "ship the one-liner" ultra mode

## Allowed pairs

- Design lane + `ponytail` helper
- Implement/debug/docs + `ponytail` or `karpathy-guidelines` helper
- `orchestrate` + any per-subtask primary (each subagent gets its own lane)
- User-named skill + nothing else

## always-on rules policy

| Rule / pack | Default | When active |
|-------------|---------|-------------|
| `skill-router` always-on adapter | ON | Always (per harness — see `adapters/`) |
| Minimal-code rules (e.g. ponytail) | OFF | Only when lane selects them |
| Broad language/framework packs | OFF | Only for the edited file stack |

## User override

If the user names a skill/plugin, or says `stop router` / `بدون موجّه`, honor that and skip auto-routing for that turn (Phase 0 may stay brief).
