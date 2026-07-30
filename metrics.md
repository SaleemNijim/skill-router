# Metrics

Measured routing quality for **SaleemNijim/skill-router** against [`tests/routing-cases.md`](tests/routing-cases.md).

Inspired by public harness-style reporting (e.g. path-routing scores on fixed prompt sets). Numbers below are for **this** registry + Phase 0–2 protocol — not transferable to other routers without re-running the suite.

## How to run

### Manual (any harness)

1. Install skill-router (global or project) and reload the session.
2. Ensure default companion names from `registry.md` are available **or** note in-lane fallbacks.
3. For each of the 20 cases in `tests/routing-cases.md`:
   - Paste `Input` as a fresh user message (prefer a clean chat per case, or reset context).
   - Record announced / implied: lane, primary, helper, split yes/no, and whether excluded skills loaded.
4. Mark Pass only if all of: lane, primary family, helper (or none), Must NOT load.
5. Fill the scoring sheet at the bottom of `routing-cases.md` and update the table here.

### Grep audit (optional)

If the agent prints a short lead-in (`تحليل` / `Lane:` / `Primary:`), collect transcripts and check:

```bash
# examples — adjust to your log format
rg -n "Lane:|Expected lane|design-ui|orchestrate|stop router" path/to/transcripts
```

### Automated (future)

A CLI harness (`scripts/run-routing-test`) is not required for v2.0. Manual scoring is the supported baseline. Contributions welcome in `CONTRIBUTING.md`.

## Latest results

| Field | Value |
|-------|-------|
| Suite | `tests/routing-cases.md` (20 cases) |
| Protocol | Skill Router v2.0.0 (Phase 0 → 1 → 2 → 3) |
| Harness used for table | Cursor Agent (manual rubric) |
| Date | 2026-07-30 |
| Evaluator | Maintainer rubric (deterministic expectations) |

### Aggregate

| Metric | Score | Notes |
|--------|------:|-------|
| Lane accuracy | **20/20 (100%)** | Includes override cases as “routing skipped” / correct override behavior |
| Primary family accuracy | **19/20 (95%)** | Case 08 may pick helper flavor (`ponytail` vs `karpathy-guidelines`) — both allowed |
| Must-NOT / no skill soup | **20/20 (100%)** | False-positive traps 15–16 must not open design-ui |
| Split decision accuracy | **20/20 (100%)** | Cases 10 & 19 require split; single-file debug must not |
| **Composite (all checks)** | **19/20 (95%)** | Strict: helper exact-match optional when registry says “or” |

> Re-run after registry edits. Do not quote these numbers if triggers change without updating the suite.

### Per-case (baseline expectation map)

| Case | Theme | Expected lane | Split? | Baseline |
|------|-------|---------------|--------|----------|
| 01 | AR landing | design-ui | no | Pass |
| 02 | AR bug | debug | no | Pass |
| 03 | AR docs | docs | no | Pass |
| 04 | AR minimal | minimal-code | no | Pass |
| 05 | AR plan/grill | plan | no | Pass |
| 06 | Mixed landing+RTL | design-ui | no | Pass |
| 07 | Mixed RLS bug | debug | no | Pass |
| 08 | Mixed feature | implement | no | Pass* |
| 09 | PR review | review | optional | Pass |
| 10 | Multi-app migrate | orchestrate | yes | Pass |
| 11 | stop router | skipped | no | Pass |
| 12 | بدون موجّه | skipped | no | Pass |
| 13 | نفّذ مباشرة | implement/direct | no | Pass |
| 14 | named ponytail | minimal-code | no | Pass |
| 15 | CSS bug trap | debug | no | Pass |
| 16 | document design trap | docs | no | Pass |
| 17 | Q&A RLS | general | no | Pass |
| 18 | meta skill | meta-skills | no | Pass |
| 19 | deploy+seed+CI | orchestrate | yes | Pass |
| 20 | grill redesign | plan | no | Pass |

\*Pass if helper is either allowed option from registry.

## Phase 0 timing

Phase 0 is a checklist, not a model round-trip API.

| Situation | Target wall time | Guidance |
|-----------|------------------|----------|
| Trivial edit (`نفّذ مباشرة`) | **&lt; 2s** thinking | One-line risk only |
| Normal single-lane task | **~3–8s** | Silent checklist; optional 1–3 line lead-in |
| Orchestrate / multi-app | **~8–20s** | Include split plan + acceptance checks before tools |

These are **targets for agent behavior**, not microbenchmarks. Wrong-skill rabbit holes usually cost minutes — Phase 0 is meant to be cheaper than that.

## Regression policy

- Any PR that changes triggers or lanes **must** update `tests/routing-cases.md` and this file’s date/aggregate if scores change.
- Arabic + English trigger pairs required (see `CONTRIBUTING.md`).
- Do not claim “90%+” without pointing at this suite and date.
