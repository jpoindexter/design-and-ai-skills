#!/usr/bin/env bash
# Install all skills into ~/.claude/skills/
# Usage: ./install.sh [--dry-run]

set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
DRY_RUN=false

[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

mkdir -p "$SKILLS_DIR"

find "$REPO_DIR" -name "SKILL.md" | sort | while read -r f; do
  skill_name=$(basename "$(dirname "$f")")
  dest="$SKILLS_DIR/$skill_name"

  if $DRY_RUN; then
    echo "[dry-run] would install: $skill_name → $dest"
  else
    mkdir -p "$dest"
    cp "$f" "$dest/SKILL.md"
    echo "installed: $skill_name"
  fi
done

echo ""
echo "Done. Reload Claude Code to pick up new skills."
