# Adversarial Review Checklist

Score each category 0–5. Total ≥ 30/50 required to pass.

## Correctness (0–5)
- [ ] Code does what the spec says
- [ ] Edge cases handled (empty input, nulls, overflow, off-by-one)
- [ ] No logical errors in conditionals/loops
- [ ] Return types match signatures

## Security (0–5)
- [ ] Input validated and sanitized
- [ ] No hardcoded secrets or credentials
- [ ] Auth/authz checks present where needed
- [ ] No SQL injection, XSS, or command injection vectors
- [ ] Dependencies audited for known vulns

## Testing (0–5)
- [ ] Unit tests cover happy path + edge cases
- [ ] No skipped or commented-out tests
- [ ] Mocking is appropriate (not over-mocked)
- [ ] Coverage meets threshold (≥ 80%)

## Maintainability (0–5)
- [ ] Functions < 50 lines, single responsibility
- [ ] Meaningful names, no cryptic abbreviations
- [ ] Types are explicit and correct
- [ ] No dead code or unused imports

## Error Handling (0–5)
- [ ] Errors caught at appropriate levels
- [ ] Error messages are actionable
- [ ] No swallowed exceptions
- [ ] Cleanup happens in finally blocks or equivalents

## Performance (0–5)
- [ ] No O(n²) where O(n) works
- [ ] No unnecessary allocations in hot paths
- [ ] Database queries optimized (N+1 eliminated)
- [ ] Caching used where appropriate

## Style & Conventions (0–5)
- [ ] Follows project linting rules
- [ ] Consistent formatting with existing code
- [ ] Comments explain "why", not "what"
- [ ] No debug/logging leftovers

## Documentation (0–5)
- [ ] Public APIs documented
- [ ] Complex logic explained inline
- [ ] README updated if behavior changed
- [ ] Breaking changes noted

## Scoring

| Score | Action |
|-------|--------|
| 40–50 | ✅ Ship it |
| 30–39 | ⚠️ Fix critical items, then ship |
| 20–29 | ❌ Major rework needed |
| < 20  | ❌ Reject — restart implementation |
