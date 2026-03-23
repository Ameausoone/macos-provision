# Jira CLI

> `ankitpokhrel/jira-cli`

## État courant

```sh
jira sprint list --current                                                    # sprint actif
jira issue list --project CPDE --type Epic --status "Action en cours"        # epics en cours
jira issue list --project CPDE --assignee$(jira me) --status "Action en cours"  # mes tâches
jira issue view CPDE-1234
jira open CPDE-1234
```
