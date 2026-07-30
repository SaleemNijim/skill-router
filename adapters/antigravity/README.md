# Antigravity adapter

Agent Skills paths used by Google Antigravity / Gemini tooling:

| Scope | Path |
|-------|------|
| Project | `<workspace>/.agents/skills/skill-router/` |
| Global (recommended for all Antigravity surfaces) | `~/.gemini/config/skills/skill-router/` |

## Install

Copy the skill folder (contents of this repo's skill package: `SKILL.md` + `registry.md`) into one of the paths above.

```bash
# Project
mkdir -p .agents/skills/skill-router
cp SKILL.md registry.md .agents/skills/skill-router/

# Global (cross-tool)
mkdir -p ~/.gemini/config/skills/skill-router
cp SKILL.md registry.md ~/.gemini/config/skills/skill-router/
```

Optional: add a short always-on note in project instructions (`AGENTS.md` / Gemini instructions) pointing at skill-router Phase 0–2.

> Tip: Prefer real directories over symlinks for Antigravity IDE discovery. Absolute custom skill paths work better than `~` shorthand in some builds.
