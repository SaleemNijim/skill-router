# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.1.0] — 2026-07-30

### Added

- `tests/routing-cases.md` — 20 deterministic routing cases (AR, mixed, overrides, traps)
- `metrics.md` — measurable suite results, Phase 0 timing targets, regression policy
- `CONTRIBUTING.md` — lane/adapter templates; bilingual trigger rule
- Registry column **Must NOT trigger on** (negative triggers / false-positive guards)
- `SKILL.md` **Examples** (5 real routing walkthroughs)
- Adapters: `adapters/opencode/`, `adapters/gemini-cli/`, `adapters/copilot/`
- README **Comparison** and **Real output** sections

### Changed

- Version metadata → `2.1.0`
- README layout lists tests, metrics, and full adapter set

## [2.0.0] — 2026-07-30

### Added

- Phase 0 multi-angle analysis before tools (simple or complex)
- Phase 2 agent splitting (`orchestrate` lane, max 4 parallel)
- Multi-harness adapters: Cursor, Claude Code, Antigravity, Codex
- `install.sh` / `install.ps1` for global and project installs
- Arabic overrides: `بدون موجّه`, `نفّذ مباشرة`, `هل فهمتني`, `قسّم`

### Changed

- **Breaking:** router is no longer a passive lane picker — analysis + optional split are mandatory (except overrides)
- Registry gained `orchestrate` and bilingual trigger examples

### Removed

- Implicit “optional one-liner only” flow as the sole contract

## [1.0.0] — 2026-07-29

### Added

- Initial `SKILL.md` + `registry.md` lane map
- Cursor always-on rule `.cursor/rules/skill-router.mdc`
- Caps: one primary + one optional helper; conflict pairs
- Overrides: named skill, `stop router` / `بدون موجّه`
- MIT license and README install via `npx skills add`

[Unreleased]: https://github.com/SaleemNijim/skill-router/compare/v2.1.0...HEAD
[2.1.0]: https://github.com/SaleemNijim/skill-router/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/SaleemNijim/skill-router/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/SaleemNijim/skill-router/releases/tag/v1.0.0
