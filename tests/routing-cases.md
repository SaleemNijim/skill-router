# Routing test cases

Deterministic expectations for Skill Router v2.  
Primary/helper names assume the default [registry.md](../registry.md) examples are installed. If a named skill is missing locally, the router must fall back in-lane without loading excluded lanes.

**How to score:** for each case, mark Pass only if **lane**, **primary**, **helper** (or none), and **Must NOT load** all match. Overrides that skip routing still require Phase 0 brief risk awareness unless noted.

---

## Arabic-only

### Case 01
```
Input: "صمّملي صفحة هبوط"
Expected lane: design-ui
Expected primary: frontend-design
Expected helper: ponytail
Must NOT load: debug, review
Split: optional (UI only → usually no)
```

### Case 02
```
Input: "أصلح هالخطأ اللي بيكسر الـ login"
Expected lane: debug
Expected primary: systematic-debugging
Expected helper: karpathy-guidelines
Must NOT load: design-ui, frontend-design
Split: no
```

### Case 03
```
Input: "اكتب README للمشروع"
Expected lane: docs
Expected primary: (project docs skill if any, else direct docs write)
Expected helper: ponytail
Must NOT load: design-ui, implement feature scaffolding
Split: no
```

### Case 04
```
Input: "أبسط حل ممكن بدون abstractions"
Expected lane: minimal-code
Expected primary: ponytail
Expected helper: karpathy-guidelines
Must NOT load: design-ui, expansive generators
Split: no
```

### Case 05
```
Input: "هل فهمتني قبل ما تبدأ؟ بدي نخطط نقل قاعدة البيانات"
Expected lane: plan
Expected primary: grill-me (or grilling / brainstorming)
Expected helper: karpathy-guidelines
Must NOT load: implement, orchestrate execution yet
Split: no (planning only)
```

---

## Mixed AR / EN

### Case 06
```
Input: "Add a landing page مع دعم RTL"
Expected lane: design-ui
Expected primary: frontend-design
Expected helper: ponytail
Must NOT load: debug, review
Split: optional (RTL + layout can stay one agent)
```

### Case 07
```
Input: "عندي bug في الـ RLS policy"
Expected lane: debug
Expected primary: systematic-debugging
Expected helper: karpathy-guidelines
Must NOT load: design-ui, frontend-design
Split: no
```

### Case 08
```
Input: "نفّذ ميزة wishlist في delivery-app"
Expected lane: implement
Expected primary: stack-matched coding skill/rule if needed (else none)
Expected helper: karpathy-guidelines or ponytail
Must NOT load: design-ui (unless UI is explicitly in scope), review-as-primary
Split: no unless monorepo fan-out appears
```

### Case 09
```
Input: "Review this PR for security"
Expected lane: review
Expected primary: code-review skill or subagent
Expected helper: —
Must NOT load: design-ui, ponytail-as-primary
Split: optional (security review subagent OK)
```

### Case 10
```
Input: "Migrate Supabase + update delivery, admin, and driver apps"
Expected lane: orchestrate
Expected primary: Phase 0 + Phase 2 split (per-subtask lanes)
Expected helper: handoff if context is long
Must NOT load: every skill at once; design-ui as sole primary
Split: yes (2–4 agents)
```

---

## Overrides

### Case 11
```
Input: "stop router — just rename this variable"
Expected lane: (routing skipped)
Expected primary: —
Expected helper: —
Must NOT load: full lane stack / orchestrate
Notes: brief think OK; no skill pile-on
```

### Case 12
```
Input: "بدون موجّه، عدّل النص فقط"
Expected lane: (routing skipped)
Expected primary: —
Expected helper: —
Must NOT load: design-ui, plan grilling
Notes: Arabic override equivalent to stop router
```

### Case 13
```
Input: "نفّذ مباشرة: زِد الـ timeout إلى 30s"
Expected lane: implement (or minimal direct edit)
Expected primary: stack/none
Expected helper: optional brief
Must NOT load: long Phase 0 grilling, plan lane interview
Notes: one-line risk check only; no multi-agent split
```

### Case 14
```
Input: "use ponytail فقط — refactor this function"
Expected lane: minimal-code (user-named skill wins)
Expected primary: ponytail
Expected helper: —
Must NOT load: frontend-design, systematic-debugging
Notes: honor named skill; Phase 0 still brief
```

---

## Edge cases / false-positive traps

### Case 15
```
Input: "fix the CSS bug on the homepage hero"
Expected lane: debug
Expected primary: systematic-debugging
Expected helper: karpathy-guidelines
Must NOT load: design-ui, frontend-design
Notes: "CSS" + "homepage" must NOT steal design-ui
```

### Case 16
```
Input: "document the design system tokens"
Expected lane: docs
Expected primary: docs skill / direct docs
Expected helper: ponytail
Must NOT load: design-ui as primary (document ≠ redesign)
```

### Case 17
```
Input: "What is RLS in Supabase?"
Expected lane: general
Expected primary: —
Expected helper: —
Must NOT load: debug, implement, design-ui
Notes: Q&A only — no coding skills
```

### Case 18
```
Input: "أضف skill جديد للـ router وحدث الـ registry"
Expected lane: meta-skills
Expected primary: skill-router (+ authoring tools)
Expected helper: handoff
Must NOT load: implement app features, design-ui
```

### Case 19
```
Input: "Deploy to Vercel and seed products and fix the failing CI"
Expected lane: orchestrate
Expected primary: Phase 2 multi-agent plan
Expected helper: handoff if long
Must NOT load: single-lane design-ui; load-all-skills
Split: yes (deploy / seed / CI as independent as possible)
```

### Case 20
```
Input: "grill me on the checkout redesign before any code"
Expected lane: plan
Expected primary: grill-me or grilling
Expected helper: karpathy-guidelines
Must NOT load: implement, frontend-design execution yet
Split: no
Notes: explicit grill trigger; wait for shared understanding
```

---

## Scoring sheet

| Case | Lane | Primary | Helper | Must-NOT | Pass? |
|------|------|---------|--------|----------|-------|
| 01 | | | | | |
| 02 | | | | | |
| … | | | | | |
| 20 | | | | | |

**Pass rate** = passes / 20.
