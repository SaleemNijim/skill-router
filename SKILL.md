---
name: skill-router
description: >-
  Routes each agent request to the right skill/rule lane so skills and always-on
  rules do not mix or conflict. Use at the start of coding, design, debug,
  review, docs, or planning work; when multiple skills could apply; when the
  user mentions router, skill conflict, توجيه, or ترتيب السكيلز; and before
  loading overlapping design, minimal-code, or large rule packs.
license: MIT
---

# Skill Router

Traffic controller for agent skills and always-on rules.

**Rule:** at most **one primary** skill and **one optional helper** per turn. Prefer no skill over the wrong skill.

## Mandatory flow

1. Classify the request into a lane from [registry.md](registry.md).
2. Activate only that row's **Primary** (and **Helper** if useful).
3. Read those skill files when needed; do **not** load excluded skills/rules.
4. Complete the task under that lane only.
5. Optional one-liner: `lane: design-ui · primary: <skill> · helper: <skill|none>`

## Caps

- Max 1 primary
- Max 1 helper
- Never activate registry **conflict pairs**
- If a named skill is missing locally, fall back to the next best available primary in-lane, or ask one short question

## Priority when ambiguous

1. User names a skill/plugin → honor it (override router)
2. Clear registry triggers → that lane
3. Edited file stack (e.g. `.tsx`) → only stack-matched language rules
4. Else `general`, or one clarifying question

## alwaysApply policy

- Keep **this** router rule always on (see `.cursor/rules/skill-router.mdc`)
- Do **not** keep heavy domain rules (minimal-code, design systems, language packs) always on unless the active lane selects them
- Broad multi-language rule packs: apply only for the stack of files you are editing

## Customization

Edit [registry.md](registry.md) to map lanes to **your** installed skills. Ship defaults are role-oriented; replace names with skills you actually have.

## Maintainer note

When adding a skill to a project, append one registry row: triggers, primary, helper, excludes. Keep the always-on rule thin; keep detail in this file and `registry.md`.
