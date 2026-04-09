# Jira CLI

> `ankitpokhrel/jira-cli`

## État courant

```sh
jira sprint list --current                                                    # sprint actif
# À faire: 14187
# Action en cours: 10588
jira issue list --project CPDE --type Epic --status 14187       # epics en cours
jira issue list --project CPDE --assignee$(jira me) --status 14187  # mes tâches
jira issue view CPDE-1234
jira open CPDE-1234
```
