# Contributing

Thanks for improving Skill Router. Keep changes small, bilingual, and testable.

## Principles

1. **One primary + one helper** — do not invent multi-skill soup.
2. **Phase 0 stays cheap** — analysis checklist, not a second product.
3. **Every English trigger needs an Arabic peer** (and vice versa when adding Arabic-first phrases).
4. **Update the suite** — if you change routing, update `tests/routing-cases.md` + `metrics.md`.

## Add a new lane

1. Append a row to `registry.md` using this template:

```markdown
| `lane-id` | EN triggers / AR triggers | Must NOT trigger on: … (→ other-lane) | primary-skill-or-fallback | optional-helper | hard excludes |
```

2. Add **at least two** test cases in `tests/routing-cases.md` (one happy path, one false-positive trap).
3. Mention the lane in `SKILL.md` only if Phase 0–2 behavior changes (usually registry-only is enough).
4. Note the change under `[Unreleased]` in `CHANGELOG.md`.

### Lane ID conventions

- lowercase kebab-case: `design-ui`, `minimal-code`, `meta-skills`
- verbs/nouns that match user intent, not tool brand names

## Add an adapter for a new tool

1. Create `adapters/<tool>/` with a thin always-on file (same six steps as `adapters/claude/skill-router.md`).
2. Document install paths in that folder or in `README.md` → **Install by AI tool**.
3. Optionally extend `install.sh` / `install.ps1` with a new `-Target` / argument.
4. Add a row to the README comparison / layout tree.
5. Do **not** fork `SKILL.md` per tool — adapters only point at the shared skill.

### Adapter template

```markdown
---
description: Skill router — multi-angle analysis, best skill lane, split large work across agents.
---

# Skill Router (always on) — <Tool>

Before acting on **any** user request (simple or complex):

1. Read the `skill-router` skill (`SKILL.md` + `registry.md`).
2. **Phase 0 — Analyze** …
3. Classify into one registry **lane** …
4. At most **one primary** + **one helper** …
5. Split into **2–4** … when warranted …
6. Do not load unrelated skills/rules …

Overrides: named skill, `stop router`, `بدون موجّه`, `نفّذ مباشرة`.

Install: <paths for this tool>
```

## Trigger naming conventions

| Kind | English | Arabic (required peer) |
|------|---------|------------------------|
| Design | landing page, UI, layout | صفحة هبوط، واجهة، تصميم |
| Debug | bug, broken, fails | خطأ، ما بيشتغل |
| Plan | plan, architecture, grill | خطّة، تصميم معماري، هل فهمتني |
| Override off | `stop router` | `بدون موجّه` |
| Override fast | (optional EN: `just do it`) | `نفّذ مباشرة` |
| Split | split work, multi-app | قسّم، وكلاء، كل شيء |

### Hard rule for PRs

> **Every new English trigger string must ship with an Arabic counterpart in the same PR** (registry Triggers cell and/or test case Input).  
> PRs that add English-only triggers will be asked to revise.

Negative triggers (`Must NOT trigger on`) should also be bilingual when the false phrase is language-specific.

## Tests

```text
1. Edit tests/routing-cases.md
2. Manually run the suite (see metrics.md → How to run)
3. Update aggregate scores + date in metrics.md if behavior changed
```

## PR checklist

- [ ] `registry.md` updated (including **Must NOT trigger on** when relevant)
- [ ] Arabic ↔ English trigger pairs added
- [ ] `tests/routing-cases.md` updated
- [ ] `metrics.md` date/scores updated if needed
- [ ] `CHANGELOG.md` `[Unreleased]` note
- [ ] Adapter/README paths correct if installing changed
- [ ] No secrets, no generated junk

## License

By contributing, you agree your changes are licensed under the MIT License.
