#!/usr/bin/env bash
# Azdar automated install + project init
# Usage: bash install.sh [node|python|rust|go|generic]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$(pwd)"

lang="${1:-generic}"
supported="node python rust go generic"
if ! echo "$supported" | grep -qw "$lang"; then
  echo "❌ Unsupported language: $lang. Choose: node python rust go generic" >&2
  exit 1
fi

echo "🔍 Checking Azdar installation..."
if ! npx azdar --version &>/dev/null; then
  echo "📦 Installing Azdar..."
  npx github:alita-agent-dev/azdar install || {
    echo "❌ Azdar install failed. Check npx and network access." >&2
    exit 1
  }
  echo "✅ Azdar installed."
else
  echo "✅ Azdar already available."
fi

echo "📋 Initializing project config ($lang)..."
mkdir -p "$PROJECT_DIR/.azdar"

template="$SKILL_DIR/templates/config-${lang}.json"
if [[ -f "$template" ]]; then
  if [[ -f "$PROJECT_DIR/.azdar/config.json" ]]; then
    echo "⚠️  .azdar/config.json exists — backing up to config.json.bak"
    cp "$PROJECT_DIR/.azdar/config.json" "$PROJECT_DIR/.azdar/config.json.bak"
  fi
  cp "$template" "$PROJECT_DIR/.azdar/config.json"
  echo "✅ Config written to .azdar/config.json"
else
  echo "❌ Template not found: $template" >&2
  exit 1
fi

echo "✅ Setup complete. Run 'azdar_start' to begin your first workflow."
