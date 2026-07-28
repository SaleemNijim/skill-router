# Skill Router Registry

Pick **one primary**. Add **at most one helper** if the row allows it. Ignore everything else for that turn unless the user names it.

> **Customize:** replace primary/helper names with skills installed in your environment. Defaults below use common public skills when present; if missing, use the lane's intent without inventing dependencies.

## Lanes

| Lane | Triggers | Primary | Helper (optional) | Hard excludes |
|------|----------|---------|-------------------|---------------|
| `design-ui` | UI, landing page, frontend design, visual identity, typography, layout / تصميم، واجهة، صفحة هبوط | `frontend-design` (if installed) else design guidance without extra packs | `ponytail` or other minimal-code skill | Competing design systems; unrelated language packs; security/review skills |
| `minimal-code` | simplest, YAGNI, lazy, less code, over-engineering / أبسط حل، تقليل كود | `ponytail` (if installed) else minimal-diff discipline | — | Scaffolding generators; unsolicited abstractions |
| `docs` | docs, README, changelog, documentation / توثيق | project docs skill if any, else write docs directly | minimal-code helper | Design-only skills |
| `debug` | bug, broken, error, fails, investigate / خطأ، ما بيشتغل | `systematic-debugging` (if installed) else root-cause debug workflow | minimal-code helper | Design skills; unsolicited refactors |
| `implement` | add feature, build, implement / نفّذ، أضف ميزة | stack-matched coding skill/rule only if needed | minimal-code helper | Unrelated language packs; design skills unless UI is in scope |
| `review` | review PR, code review / مراجعة | code-review skill or subagent if available | — | Design-only skills; ultra-deletion mode that blocks thorough review |
| `plan` | plan, architecture, tradeoffs / خطّة، تصميم معماري | planning/brainstorming skill if available | — | Jumping straight to implementation skills |
| `meta-skills` | add skill, router, registry, install plugin / سكيل، موجّه | `skill-router` + skill/rule authoring tools | — | Unrelated domain skills |
| `general` | Q&A, explanation, no code change | — (no skill) | — | Don't load coding/design skills |

## Conflict pairs (never co-activate)

- Two competing design authorities as peers
- Multiple unrelated language rule packs in one turn (React + Vue + Python + …) — pick the stack you are editing
- Ultra-minimal / delete-first mode + expansive scaffolding or coverage-max skills
- Deep review mode + "ship the one-liner and challenge the requirement" ultra mode

## Allowed pairs

- Design lane + minimal-code helper — distinctive UI, lean implementation
- Implement/debug/docs + minimal-code helper — smallest correct change
- User-named skill + nothing else

## alwaysApply rules policy

| Rule / pack | Default | When active |
|-------------|---------|-------------|
| `skill-router` | ON | Always |
| Minimal-code rules (e.g. ponytail) | OFF | Only when lane selects them |
| Broad language/framework packs | OFF | Only for the edited file stack |

## User override

If the user names a skill/plugin, or says `stop router` / `بدون موجّه`, honor that and skip auto-routing for that turn.
