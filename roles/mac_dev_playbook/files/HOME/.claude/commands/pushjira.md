Read the current git diff to understand what changes were made, then create an appropriately named branch based on the actual changes, commit with a descriptive message that reflects the specific modifications, push the branch to remote.
Use Jira cli, create a Jira ticket with the same title and description as the PR, try to search to matching assigned epic tickets, link it to the epic if found and link the PR to the ticket.
Open a GitHub pull request with a relevant title and detailed description of what was changed, with this pattern in mind:
`type(scope): $JIRA_ID Short description`

Where `type` is one of semantic release types (feat, fix, docs, style, refactor, perf, test, chore), `scope` is a brief description of the area affected (optional), and `$JIRA_ID` is the Jira ticket ID created earlier.



- **Config changes**: `feat/add-github-java-workflows-testbed` → "feat: add github-java-project-workflows-testbed repository"
- **Bug fixes**: `fix/resolve-auth-timeout` → "fix: resolve authentication timeout in login flow"
- **Documentation**: `docs/update-api-examples` → "docs: update API usage examples with new endpoints"
