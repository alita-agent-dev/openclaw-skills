# Workflow Patterns

Common Azdar workflow patterns. Use these to inform how you frame the `task` in `azdar_start`.

## TDD (Test-Driven Development)

1. Start with `azdar_start` describing the feature
2. In **plan** phase: write test cases first
3. In **implement**: write minimal code to pass tests
4. **Review**: verify test coverage ≥ 80%, no skipped tests

**Task framing:** "Implement [feature] using TDD. Write failing tests first, then minimal implementation."

## Security-Focused

1. `azdar_start` with security emphasis
2. **Research** phase identifies attack vectors
3. **Specify** defines security requirements as constraints
4. **Review** uses security checklist from `review-checklist.md`

**Task framing:** "Security audit and harden [component]. Focus on input validation, auth, and data exposure."

## Legacy Refactor

1. `azdar_start` targeting specific module/file
2. **Research**: map dependencies and callers
3. **Plan**: incremental refactor steps (one file at a time)
4. **Implement**: preserve behavior, add tests before changing

**Task framing:** "Refactor [module] for [clarity/performance/maintainability]. Preserve all existing behavior."

## Bug Fix

1. `azdar_start` describing the bug with reproduction steps
2. **Research**: trace root cause
3. **Specify**: define the fix scope (minimal)
4. **Review**: verify fix doesn't introduce regressions

**Task framing:** "Fix bug: [description]. Reproduction: [steps]. Expected: [behavior]."

## Quick Patch

For urgent fixes with abbreviated workflow:
1. `azdar_start` with `scope: "quick"`
2. Skip research/specify — go straight to plan → implement
3. Light review (syntax + tests only)

**Task framing:** "Quick fix: [issue]. Minimal change, ship fast."
