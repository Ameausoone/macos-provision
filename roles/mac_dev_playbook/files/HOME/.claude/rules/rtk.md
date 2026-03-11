---
description: Use RTK to prefix all shell commands in order to reduce token usage. Apply to every Bash tool call without exception.
globs: ["**/*"]
alwaysApply: true
---

# RTK (Rust Token Killer) - Token-Optimized Commands

## Golden Rule

**Always prefix commands with `rtk`**. If RTK has a dedicated filter, it uses it. If not, it passes through unchanged. This means RTK is always safe to use.

**Important**: Even in command chains with `&&`, use `rtk`:

```bash
# ❌ Wrong
git add . && git commit -m "msg" && git push

# ✅ Correct
rtk git add . && rtk git commit -m "msg" && rtk git push
```

## Supported Categories

RTK filters output for: git, gh, cargo, pnpm/npm/npx, vitest, playwright, tsc, lint, prettier, next, prisma, docker, kubectl, curl, wget, ls, read, grep, find, err, log, json, deps, env, summary, diff.

Git passthrough works for ALL subcommands.

## Meta Commands

```bash
rtk gain              # Token savings analytics
rtk gain --history    # Command history with savings
rtk discover          # Find missed RTK usage
rtk proxy <cmd>       # Run without filtering (debug)
```
