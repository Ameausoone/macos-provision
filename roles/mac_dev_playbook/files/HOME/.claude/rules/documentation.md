# Documentation

## Markdown

Respect these rules when writing Markdown files:

* MD032/blanks-around-lists Lists should be surrounded by blank lines
* MD031/blanks-around-fences Fenced code blocks should be surrounded

## Documentation language

When writing documentation, write it by default in English, unless specified otherwise.

## README Structure & Design

### Purpose
Keep READMEs short, direct, and user-focused. Answer "what does this do and how do I use it" in the minimum words necessary.

### Structure (in order)

1. **Project name** (h1)
   - One-line description of what it does

2. **Prerequisites** (optional, if needed)
   - Only list what's not obvious
   - Format: bullet list with version requirements

3. **Installation / Setup**
   - Minimum steps to get running
   - Use code blocks for commands
   - No explanation unless command is unclear

4. **Usage**
   - Core commands/operations only
   - One example per major use case
   - Format: command + brief output if helpful

5. **Configuration** (optional, if needed)
   - Only if user needs to configure something
   - List key variables/files
   - No deep explanations

### Don'ts
- No badges/shields unless critical (build status, version)
- No "About", "Features", "Why" sections unless project is a library/framework
- No contribution guidelines (use CONTRIBUTING.md if needed)
- No lengthy examples or tutorials (link to docs if complex)
- No excessive markdown formatting (keep it plain)
- No "Table of Contents" for short READMEs (<200 lines)

### Example Template

```markdown
# project-name

Brief one-line description.

## Installation

\`\`\`bash
npm install project-name
\`\`\`

## Usage

\`\`\`bash
project-name command --flag value
\`\`\`

## Configuration

Set `CONFIG_VAR` in `.env` file.
```

### Tone
- Imperative mood ("Run this", not "You should run this")
- No fluff or marketing language
- Direct and technical

## CONTRIBUTING.md

Projects should include a CONTRIBUTING.md file that explains how to contribute.

### Purpose
Document the contribution workflow and maintainer processes. Answer "how do I contribute" and "how do maintainers release."

### Structure (in order)

1. **Development Setup**
   - Prerequisites with versions
   - Clone and install commands
   - How to run tests locally

2. **Making Changes**
   - Branch naming (if specific convention)
   - Commit message format (if required)
   - Code style/linting commands

3. **Submitting Changes**
   - How to create PR
   - What to include in PR description
   - CI/testing requirements

4. **For Maintainers** (optional)
   - Release process steps
   - Version management
   - Publishing/deployment

### Don'ts
- No lengthy philosophy or "why contribute" sections
- No code of conduct details (link to CODE_OF_CONDUCT.md)
- No issue templates (those go in .github/)
- No donation/sponsorship info (use README badges if needed)

### Example Template

```markdown
# Contributing

## Development Setup

Prerequisites: Node.js 18+, Docker

\`\`\`bash
git clone https://github.com/user/project
cd project
npm install
npm test
\`\`\`

## Making Changes

1. Create branch: `git checkout -b fix/issue-name`
2. Make changes
3. Run tests: `npm test`
4. Run linter: `npm run lint`

## Submitting Changes

1. Push branch
2. Create PR with description of changes
3. Wait for CI to pass

## For Maintainers

### Releasing

1. Update version: `npm version patch|minor|major`
2. Update `CHANGELOG.md`
3. Push: `git push && git push --tags`
4. Publish: `npm publish`
```

### Tone
- Same as README: imperative, direct, no fluff
- Commands over explanations
