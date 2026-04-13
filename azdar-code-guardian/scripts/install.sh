#!/usr/bin/env bash
# Azdar automated install + project init
# Usage: bash install.sh [node|python|rust|go|generic]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$(pwd)"

show_help() {
  echo "Usage: bash install.sh [language]"
  echo ""
  echo "Installs Azdar and initializes project config."
  echo ""
  echo "Languages: node, python, rust, go, generic (default: auto-detect)"
  echo ""
  echo "Options:"
  echo "  --help    Show this help message"
  echo "  --dry-run Show what would be done without executing"
  exit 0
}

if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
  show_help
fi

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
  shift
fi

# Auto-detect language if not specified
lang="${1:-}"
supported="node python rust go generic"

if [[ -z "$lang" ]]; then
  if [[ -f "package.json" ]]; then
    lang="node"
  elif [[ -f "requirements.txt" ]] || [[ -f "pyproject.toml" ]] || [[ -f "setup.py" ]]; then
    lang="python"
  elif [[ -f "Cargo.toml" ]]; then
    lang="rust"
  elif [[ -f "go.mod" ]]; then
    lang="go"
  else
    lang="generic"
  fi
  echo "🔍 Auto-detected language: $lang"
fi

if ! echo "$supported" | grep -qw "$lang"; then
  echo "❌ Unsupported language: $lang. Choose: node python rust go generic" >&2
  exit 1
fi

if [[ "$DRY_RUN" == true ]]; then
  echo "📋 Dry run — would install Azdar and copy config-${lang}.json to .azdar/config.json"
  exit 0
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
