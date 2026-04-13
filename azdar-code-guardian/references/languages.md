# Language Tooling Configs

Per-language lint/test/build/security commands for `.azdar/config.json`.

## TypeScript / Node

```json
{
  "lint": "npx eslint . --ext .ts,.tsx",
  "test": "npx jest --passWithNoTests",
  "build": "npx tsc --noEmit",
  "security": "npx audit-ci --moderate"
}
```

**Deps:** `eslint`, `@typescript-eslint/*`, `jest`, `typescript`

## Python

```json
{
  "lint": "ruff check .",
  "test": "pytest --tb=short -q",
  "build": "python -m compileall . -q",
  "security": "bandit -r . -ll"
}
```

**Deps:** `ruff`, `pytest`, `bandit`

## Rust

```json
{
  "lint": "cargo clippy -- -D warnings",
  "test": "cargo test --quiet",
  "build": "cargo build --release",
  "security": "cargo audit"
}
```

**Deps:** `clippy`, `cargo-audit`

## Go

```json
{
  "lint": "golangci-lint run ./...",
  "test": "go test ./... -count=1",
  "build": "go build ./...",
  "security": "gosec ./..."
}
```

**Deps:** `golangci-lint`, `gosec`

## Ruby

```json
{
  "lint": "bundle exec rubocop",
  "test": "bundle exec rspec --format progress",
  "build": "bundle check",
  "security": "bundle audit check"
}
```

**Deps:** `rubocop`, `rspec`, `bundler-audit`
