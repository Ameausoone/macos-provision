# strict
Be strict on proposed code

# bash-command-fix
When using a regular unix command in bash tool, always use /usr/bin/ path instead of regular `cd` command to avoid zsh config issues like "__autoenv_cd" errors

# markdown
respect this rules when write markdown files:
* MD032/blanks-around-lists Lists should be surrounded by blank lines
* MD031/blanks-around-fences Fenced code blocks should be surrounded

# pull-request-template
Respect semantic release for commit messages and PR titles
Do not specify "Generated with [Claude Code]" in pull request descriptions or commit messages
Be concise and clear in descriptions, go right to the point

# jira
Privileged Jira MCP server to interact with Jira server.

# self-improvement
If you make a mistake, or get an error and find the solution, propose a change in ~/CLAUDE.md to avoid making the same mistake again.

# copilot-instructions.md
If the file `.github/copilot-instructions.md` exists in a repository, read it and follow the instructions.

# documentation
When writing documentation, write it by default in English, unless specified otherwise.

# simplicity
Keep code and documentation simple and straightforward:
* Write tight, simple scripts without excessive formatting
* Avoid colored output in error messages unless specifically requested
* READMEs should be minimal and straight to the point - only essential setup and usage info
* No verbose explanations or examples unless needed
