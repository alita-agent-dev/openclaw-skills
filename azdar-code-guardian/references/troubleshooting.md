# Troubleshooting

## `npx azdar` not found
- Ensure Node.js ≥ 18 is installed
- Run `npx github:alita-agent-dev/azdar install` directly
- Check npm registry access: `npm ping`

## `azdar_start` returns error
- `project_dir` must be an **absolute** path
- Directory must exist and contain a `.azdar/config.json`
- Run `scripts/install.sh` to set up config

## Workflow stuck in a phase
- Use `azdar_status` to check current phase
- Ensure your `azdar_respond` calls contain substantive output
- Empty or "I don't know" responses may cause retries

## Config parsing errors
- `.azdar/config.json` must be valid JSON
- Check for trailing commas (not allowed in JSON)
- Use `jq . .azdar/config.json` to validate

## `azdar_respond` not accepted
- You must respond to the **last prompt** Azdar gave you
- Don't skip ahead — process each phase in order
- If you see a `calibrate` prompt, answer the calibration questions first

## Pre-commit hook fails silently
- Check `.git/hooks/pre-commit` is executable: `chmod +x`
- Verify the symlink points to the right script
- Run `bash .git/hooks/pre-commit` manually to see output

## Learnings not persisting
- `azdar_learn` requires `learning` (non-empty string)
- `scope` must be `"project"` or `"global"`
- `project_dir` must match the project you're working in
