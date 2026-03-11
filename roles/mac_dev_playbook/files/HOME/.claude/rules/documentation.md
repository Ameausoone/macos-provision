---
paths:
  - "**/*.md"
---

# Documentation

## Markdown

Respect these rules when writing Markdown files:

- MD032/blanks-around-lists Lists should be surrounded by blank lines
- MD031/blanks-around-fences Fenced code blocks should be surrounded

## Documentation language

Write documentation in English by default, unless specified otherwise.

## README Structure & Design

Keep READMEs short, direct, and user-focused. Answer "what does this do and how do I use it" in the minimum words necessary.

### Structure (in order)

1. **Project name** (h1) — one-line description
2. **Prerequisites** (optional) — only non-obvious items, bullet list with versions
3. **Installation / Setup** — minimum steps, code blocks, no extra explanation
4. **Usage** — core commands only, one example per major use case
5. **Configuration** (optional) — key variables/files only

### Don'ts

- No badges/shields unless critical
- No "About", "Features", "Why" sections unless it's a library/framework
- No contribution guidelines inline (use CONTRIBUTING.md)
- No lengthy examples, tutorials, or Table of Contents for short READMEs

### Tone

- Imperative mood ("Run this", not "You should run this")
- No fluff or marketing language
- Direct and technical

## CONTRIBUTING.md

Include when relevant. Structure: Development Setup → Making Changes → Submitting Changes → For Maintainers (release process). Same tone as README: imperative, commands over explanations. No philosophy, no code of conduct inline.
