# Language-Specific Tooling Configs

## TypeScript / Node.js

```json
{
  "tooling": {
    "test": "npm test",
    "lint": "npx eslint src/ --max-warnings 0",
    "build": "npm run build",
    "security": "npm audit --audit-level=moderate"
  },
  "verification": {
    "tdd_threshold": 50,
    "coverage_threshold": 80
  }
}
```

## Python

```json
{
  "tooling": {
    "test": "pytest tests/ -v --tb=short",
    "lint": "ruff check src/",
    "build": "python -m py_compile src/",
    "security": "pip audit || safety check"
  }
}
```

## Rust

```json
{
  "tooling": {
    "test": "cargo test",
    "lint": "cargo clippy -- -D warnings",
    "build": "cargo build --release",
    "security": "cargo audit"
  }
}
```

## Go

```json
{
  "tooling": {
    "test": "go test ./... -v",
    "lint": "golangci-lint run",
    "build": "go build ./...",
    "security": "govulncheck ./..."
  }
}
```

## Ruby

```json
{
  "tooling": {
    "test": "bundle exec rspec",
    "lint": "bundle exec rubocop",
    "build": "bundle exec rake build",
    "security": "bundle audit check"
  }
}
```

## Skip Tooling (No Build Step)

For projects without a build/test toolchain, or when working in environments without tooling installed:

```json
{
  "tooling": {
    "test": "echo 'skip: no test runner'",
    "lint": "echo 'skip: no linter'",
    "build": "echo 'skip: no build step'",
    "security": "echo 'skip: no security scanner'"
  }
}
```
