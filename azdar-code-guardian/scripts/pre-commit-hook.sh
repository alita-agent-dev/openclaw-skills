#!/usr/bin/env bash
# Pre-commit hook: runs quality gates from .azdar/config.json
# Install: ln -sf ../../skills/azdar-code-guardian/scripts/pre-commit-hook.sh .git/hooks/pre-commit
set -euo pipefail

PROJECT_DIR="$(cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" && pwd)"
CONFIG="$PROJECT_DIR/.azdar/config.json"

if [[ ! -f "$CONFIG" ]]; then
  echo "⚠️  No .azdar/config.json found — skipping gates."
  exit 0
fi

failed=0

run_gate() {
  local label="$1"; shift
  local cmd="$*"
  echo "▸ $label: $cmd"
  if eval "$cmd"; then
    echo "  ✅ $label passed"
  else
    echo "  ❌ $label FAILED (exit $?)" >&2
    failed=1
  fi
}

# Extract commands from config using basic grep/sed (no jq dependency)
extract_cmd() {
  local key="$1"
  grep -o "\"$key\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" "$CONFIG" | head -1 | sed "s/.*:[[:space:]]*\"\\(.*\\)\"/\\1/"
}

lint=$(extract_cmd "lint")
test_cmd=$(extract_cmd "test")
build=$(extract_cmd "build")
security=$(extract_cmd "security")

[[ -n "$lint" ]] && run_gate "Lint" "$lint"
[[ -n "$test_cmd" ]] && run_gate "Tests" "$test_cmd"
[[ -n "$build" ]] && run_gate "Build" "$build"
[[ -n "$security" ]] && run_gate "Security" "$security"

if [[ $failed -ne 0 ]]; then
  echo "" >&2
  echo "🚫 Quality gates failed. Fix issues before committing." >&2
  exit 1
fi

echo ""
echo "✅ All quality gates passed."
exit 0
