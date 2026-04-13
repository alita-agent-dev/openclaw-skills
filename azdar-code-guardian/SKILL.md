---
name: azdar-code-guardian
description: "Deterministic code quality workflow with adversarial review, quality gates, and learning system. Use when writing, reviewing, or improving code that needs real verification — not just lint passes. Triggers on: code review, security audit, quality gates, test-driven development, TDD, code quality enforcement, adversarial review, pre-commit checks, CI quality."
metadata:
  openclaw:
    requires:
      bins:
        - npx
    emoji: "🛡️"
    homepage: "https://github.com/alita-agent-dev/azdar"
version: 1.0.0
---

# Azdar Code Guardian

Automated code quality enforcement with adversarial review and learning. Every code change goes through a deterministic pipeline: specify → implement → adversarial review → gate → learn.

## Quick Start

### 1. Install Azdar in your project

```bash
npx github:alita-agent-dev/azdar install
```

This creates `.azdar/` with `config.json`. Edit it to match your tooling:

```json
{
  "tooling": {
    "test": "npm test",
    "lint": "npx eslint src/",
    "build": "npm run build",
    "security": "npm audit --audit-level=moderate"
  }
}
```

### 2. Start a task

Tell the agent what to build or fix. The workflow runs automatically:

```
"Add JWT authentication to the Express API"
```

The agent calls `azdar_start` → calibrates depth → runs phases → verifies.

### 3. Review gate results

Each phase has a quality gate. If it fails, the agent fixes issues and retries. You see `pending_contributions` for approval before anything ships.

## Core Workflow

Phases run in order. Each gates on the previous:

1. **Calibrate** — Assesses task complexity (standard/deep), estimates files affected
2. **Research** — Explores codebase, identifies patterns, checks dependencies
3. **Specify** — Writes formal requirements, acceptance criteria, persona reviews
4. **Plan** — Breaks into waves/stories/tasks with LOC estimates
5. **Implement** — Writes code, runs verification (test/lint/build/security)
6. **Adversarial Review** — Hostile security audit with bounty-hunter prompt, scores findings
7. **Retrospection** — Extracts learnings from findings, persists rules for future tasks

## Configuration

### Tooling Commands

Configure in `.azdar/config.json`:

```json
{
  "tooling": {
    "test": "your-test-command",
    "lint": "your-lint-command",
    "build": "your-build-command",
    "security": "your-security-audit-command"
  },
  "verification": {
    "tdd_threshold": 50,
    "coverage_threshold": 80
  }
}
```

Skip any tool by setting it to a no-op: `"test": "echo 'skip'"`.

### Depth Levels

- **standard** — Bug fixes, small features (< 10 files). Fast.
- **deep** — Greenfield, architecture changes, 10+ files. Thorough.

## Adversarial Review Checklist

Every implementation gets reviewed against:

| Category | Checks |
|----------|--------|
| Secrets | Hardcoded passwords, API keys, tokens, connection strings |
| Injection | SQL/NoSQL string concat, unsanitized shell input |
| Auth | Bypass paths, missing permission checks |
| Validation | Unvalidated user input reaching DB/filesystem/network |
| Error Handling | Empty catches, swallowed errors, missing boundaries |
| Resource Leaks | Unclosed connections, file handles, streams |
| Race Conditions | Shared mutable state without synchronization, TOCTOU |
| Data Exposure | Sensitive data in logs, error messages, API responses |
| Dependencies | Vulnerable imports, floating version ranges |
| Tests | Untested code paths, tests asserting nothing |

Scores: 0-10 per category, weighted. Below threshold = block.

## Learning System

Azdar captures rules from review findings:

- **Project rules** — Stored in `.azdar/learnings/project/`
- **Global rules** — Stored in `.azdar/learnings/global/`
- **Active window** — 30 days, dormant after 60, archived after 180

Rules are loaded on future tasks to prevent repeat mistakes.

## MCP Integration

If using OpenClaw with MCP, Azdar exposes these tools:

- `azdar_start` — Start a new workflow task
- `azdar_respond` — Continue the workflow (agent responds to prompts)
- `azdar_status` — Check current workflow state
- `azdar_learn` — Capture a learning at any time

## Language Examples

See [references/languages.md](references/languages.md) for per-language tooling configs.

## Common Patterns

See [references/patterns.md](references/patterns.md) for workflow patterns (TDD-first, security-focused, legacy refactor).
