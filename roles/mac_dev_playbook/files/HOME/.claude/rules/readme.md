# README Structure & Design

## Purpose
Keep READMEs short, direct, and user-focused. Answer "what does this do and how do I use it" in the minimum words necessary.

## Structure (in order)

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

## Don'ts
- No badges/shields unless critical (build status, version)
- No "About", "Features", "Why" sections unless project is a library/framework
- No contribution guidelines (use CONTRIBUTING.md if needed)
- No lengthy examples or tutorials (link to docs if complex)
- No excessive markdown formatting (keep it plain)
- No "Table of Contents" for short READMEs (<200 lines)

## Example Template

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

## Tone
- Imperative mood ("Run this", not "You should run this")
- No fluff or marketing language
- Direct and technical
