# Workflow Patterns

## Pattern 1: TDD-First (Test-Driven Development)

Best for: New features, critical business logic, APIs.

1. Start task: "Add X with TDD"
2. Calibrate → Research → Specify
3. Plan includes: write tests FIRST, then implement
4. Implement phase writes tests before code
5. Gate: tests must pass, coverage ≥ threshold
6. Adversarial review catches edge cases tests missed

## Pattern 2: Security-Focused

Best for: Auth flows, payment processing, user input handling.

1. Start task: "Add X with security review"
2. Calibrate → deep (forced)
3. Specify includes: threat model, attack surface analysis
4. Implement with security checklist in context
5. Adversarial review uses hostile bounty-hunter prompt
6. Retrospection captures security learnings as global rules

## Pattern 3: Legacy Refactor

Best for: Migrating old code, dependency upgrades, framework migration.

1. Start task: "Refactor X to use Y"
2. Calibrate → deep
3. Research phase: maps all usages, identifies breaking changes
4. Specify: lists every file touched, expected behavior changes
5. Plan: incremental waves (one module at a time)
6. Gate: all existing tests still pass after each wave

## Pattern 4: Bug Fix

Best for: Production bugs, regression fixes.

1. Start task: "Fix bug where X happens when Y"
2. Calibrate → standard
3. Research: find root cause, identify affected paths
4. Specify: root cause, fix approach, regression test
5. Plan: minimal change + regression test
6. Gate: regression test passes, no new test failures

## Pattern 5: Quick Patch (Skip Review)

Best for: Hotfixes, typos, config changes.

1. Start task with "quick:" prefix: "quick: fix typo in README"
2. Calibrate → standard
3. Skips adversarial review
4. Still runs verification (test/lint/build)
5. Gate: verification passes only

## Combining Patterns

Tasks can combine patterns. Example: "Add payment processing with security review and TDD" uses both Pattern 1 and 2.
