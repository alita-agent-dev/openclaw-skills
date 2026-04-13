---
name: azdar-code-guardian
description: >
  Deterministic code quality workflow with adversarial review, quality gates, and learning system.
  Use when writing, reviewing, or improving code that needs real verification — not just lint passes.
  Triggers on: code review, security audit, quality gates, test-driven development, TDD, code quality
  enforcement, adversarial review, pre-commit checks, CI quality.
version: 1.0.0
metadata:
  openclaw:
    emoji: "🛡️"
    homepage: "https://github.com/alita-agent-dev/azdar"
    requires:
      bins:
        - npx
---

# Azdar Code Guardian

Run deterministic code quality workflows using [Azdar](https://github.com/alita-agent-dev/azdar).
Azdar enforces a multi-phase pipeline: calibrate → research → specify → plan → implement → adversarial review → retrospection.

## MCP Tools

| Tool | Purpose |
|------|---------|
| `azdar_start` | Start a workflow. Args: `task` (description), `project_dir` (absolute path) |
| `azdar_respond` | Return your LLM output to Azdar after processing its prompt. Args: `response`, `project_dir` |
| `azdar_status` | Check current workflow state. Arg: `project_dir` |
| `azdar_learn` | Capture a lesson learned. Args: `learning`, `scope` (project/global), `project_dir` |

## Quick Start

### 1. Install (if needed)
```bash
bash scripts/install.sh [node|python|rust|go|generic]
```

### 2. Run a Workflow
```
azdar_start → read prompt → process → azdar_respond → repeat until done
```

**Always** pass `project_dir` as an absolute path to `azdar_start` and `azdar_respond`.

### 3. Capture Learnings
After each workflow, use `azdar_learn` to persist insights. Use `scope: "project"` for repo-specific rules, `"global"` for universal patterns.

## Workflow Patterns

See `references/patterns.md` for TDD, security-focused, legacy refactor, bug fix, and quick patch patterns.

## Pre-commit Hook

```bash
# .git/hooks/pre-commit → ln -s ../../scripts/pre-commit-hook.sh
bash scripts/pre-commit-hook.sh
```

Reads `.azdar/config.json` and runs lint/test/build/security gates. Exits non-zero on failure.

## Standalone Security Scan

```bash
bash scripts/security-scan.sh [path]
```

Scans for hardcoded secrets, debug code, TODO/FIXME, console.logs — no full workflow needed.

## Language Configs

See `references/languages.md` for per-language tooling recommendations.
Templates in `templates/` provide ready-made `.azdar/config.json` files for common stacks.

## Adversarial Review Checklist

See `references/review-checklist.md` for the full scoring rubric used during the review phase.

## Troubleshooting

See `references/troubleshooting.md` for common issues (install failures, stuck workflows, config errors).
