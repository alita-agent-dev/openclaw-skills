#!/usr/bin/env bash
# Standalone security scan — no full Azdar workflow needed
# Usage: bash security-scan.sh [path]  (defaults to .)
set -euo pipefail

scan_dir="${1:-.}"

if [[ ! -d "$scan_dir" ]]; then
  echo "❌ Directory not found: $scan_dir" >&2
  exit 1
fi

echo "🔍 Scanning $scan_dir for security issues..."
echo ""

issues=0

check() {
  local label="$1"; shift
  local pattern="$1"; shift
  local desc="$*"
  local matches
  matches=$(grep -rn --include='*.ts' --include='*.tsx' --include='*.js' --include='*.jsx' \
    --include='*.py' --include='*.rb' --include='*.go' --include='*.rs' \
    -E "$pattern" "$scan_dir" 2>/dev/null | grep -v node_modules | grep -v '.git/' || true)
  if [[ -n "$matches" ]]; then
    count=$(echo "$matches" | wc -l)
    echo "⚠️  $label ($count): $desc"
    echo "$matches" | head -10
    echo ""
    issues=$((issues + count))
  fi
}

check "Hardcoded secrets" \
  "(password|api_key|secret|token|private_key)\s*[:=]\s*['\"][^'\"]{8,}" \
  "Possible hardcoded credentials"

check "AWS keys" \
  "AKIA[0-9A-Z]{16}" \
  "Hardcoded AWS access key"

check "Private keys" \
  "-----BEGIN (RSA |EC )?PRIVATE KEY-----" \
  "Embedded private key"

check "TODO/FIXME" \
  "TODO|FIXME|HACK|XXX" \
  "Leftover action items in code"

check "Debug code" \
  "console\.(log|debug|info|warn|error)\(" \
  "Console logging statements"

check "Debugger" \
  "debugger;|breakpoint\(\)" \
  "Debugger statements left in code"

check "Debug imports" \
  "import pdb|import ipdb|require\('debug'\)" \
  "Debug tool imports"

check "Hardcoded URLs" \
  "https?://(localhost|127\.0\.0\.1|0\.0\.0\.0)" \
  "Hardcoded localhost URLs"

if [[ $issues -eq 0 ]]; then
  echo "✅ No security issues found."
  exit 0
else
  echo "Found $issues potential issue(s). Review and fix before committing." >&2
  exit 1
fi
