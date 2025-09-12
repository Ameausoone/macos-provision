# Strict
Be strict on proposed code.

# bash-command-fix
When using a regular unix command in bash tool, always use /usr/bin/ path instead of regular `cd` command to avoid zsh config issues like "__autoenv_cd" errors.

# markdown
respect this rules when write mkd:
* MD032/blanks-around-lists Lists should be surrounded by blank lines
* MD031/blanks-around-fences Fenced code blocks should be surrounded

# pull-request-template
Respect semantic release for commit messages and PR titles.
Do not specify "Generated with [Claude Code]" in pull request descriptions or commit messages.

# jira

Use jira cli for jira operations.
USAGE
jira <command> <subcommand> [flags]
MAIN COMMANDS
board       Board manages Jira boards in a project
epic        Epic manage epics in a project
issue       Issue manage issues in a project
open        Open issue in a browser
project     Project manages Jira projects
release     Release manages Jira Project versions
sprint      Sprint manage sprints in a project board
