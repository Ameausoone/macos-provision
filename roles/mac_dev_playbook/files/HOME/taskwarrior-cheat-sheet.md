# TaskWarrior + Timewarrior

## TaskWarrior — task management

### Add & modify

```sh
task add "Fix login bug" project:backend due:friday +urgent
task <id> modify due:monday priority:H
task <id> annotate "note added to task"
task <id> done
task <id> delete
```

### Attributes

| Attribute     | Purpose                               |
|---------------|---------------------------------------|
| `due:`        | hard deadline                         |
| `scheduled:`  | when you plan to start                |
| `wait:`       | hidden until this date                |
| `until:`      | auto-expires if not done              |
| `priority:`   | H / M / L                             |
| `project:`    | grouping                              |
| `+tag`        | free label                            |

### Filter & view

```sh
task list
task project:backend list
task +urgent list
task due:today list
task due.before:2026-04-01 list
task next                              # smart prioritized view
```

### Recurrence

```sh
task add "Weekly sync" recur:weekly due:friday
task add "Monthly backup" recur:monthly due:1st
```

---

## Timewarrior — time tracking

```sh
timew start backend api               # start timer with tags
timew stop                            # stop current timer
timew continue                        # resume last timer
timew summary                         # today's report
timew summary :week                   # this week
timew summary :month
timew report day                      # day view
```

---

## Integration (TaskWarrior → Timewarrior)

```sh
# install hook (run once)
cp /usr/local/share/doc/task/hooks/on-modify.timewarrior ~/.task/hooks/
chmod +x ~/.task/hooks/on-modify.timewarrior

# usage: start/stop automatically tracks time
task <id> start
task <id> stop
```
