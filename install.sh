#!/usr/bin/env bash
# Install skill-router into common AI harness paths (macOS/Linux)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-all}"   # cursor | claude | antigravity | agents | all
SCOPE="${2:-global}" # global | project

install_skill() {
  local dest="$1"
  mkdir -p "$dest"
  cp -f "$ROOT/SKILL.md" "$ROOT/registry.md" "$dest/"
  echo "Skill -> $dest"
}

install_cursor_rule() {
  local dest="$1"
  mkdir -p "$dest"
  cp -f "$ROOT/.cursor/rules/skill-router.mdc" "$dest/"
  echo "Cursor rule -> $dest"
}

install_claude_rule() {
  local dest="$1"
  mkdir -p "$dest"
  cp -f "$ROOT/adapters/claude/skill-router.md" "$dest/skill-router.md"
  echo "Claude rule -> $dest"
}

case "$SCOPE" in
  project) BASE="$(pwd)" ;;
  *) BASE="$HOME" ;;
esac

do_cursor() {
  if [[ "$SCOPE" == "project" ]]; then
    install_skill "$BASE/.cursor/skills/skill-router"
    install_cursor_rule "$BASE/.cursor/rules"
  else
    install_skill "$HOME/.cursor/skills/skill-router"
    install_cursor_rule "$HOME/.cursor/rules"
  fi
}

do_claude() {
  if [[ "$SCOPE" == "project" ]]; then
    install_skill "$BASE/.claude/skills/skill-router"
    install_claude_rule "$BASE/.claude/rules"
  else
    install_skill "$HOME/.claude/skills/skill-router"
    install_claude_rule "$HOME/.claude/rules"
  fi
}

do_antigravity() {
  if [[ "$SCOPE" == "project" ]]; then
    install_skill "$BASE/.agents/skills/skill-router"
  else
    install_skill "$HOME/.gemini/config/skills/skill-router"
  fi
}

do_agents() {
  install_skill "$HOME/.agents/skills/skill-router"
}

case "$TARGET" in
  cursor) do_cursor ;;
  claude) do_claude ;;
  antigravity) do_antigravity ;;
  agents) do_agents ;;
  all) do_cursor; do_claude; do_antigravity; do_agents ;;
  *) echo "Usage: ./install.sh [cursor|claude|antigravity|agents|all] [global|project]"; exit 1 ;;
esac

echo "Done. Restart / reload your agent session."
