# Git

## Branch

```sh
git switch -c <branch>                     # create and checkout branch
git push -d <remote> <branch>              # delete remote branch
git branch -d <branch>                     # delete local branch
git branch -D <branch>                     # force delete local branch
git branch -a                              # list all branches (local + remote)
git fetch --all && git pull --all
```

## Reset

```sh
git reset --hard HEAD                      # discard all staged and unstaged changes
git rm --cached <file>                     # unstage file (keep on disk)
```

## Cherry Pick

```sh
git switch develop
git cherry-pick <commit-hash>
```

## Rebase

```sh
git rebase -i HEAD~3                       # rewrite last 3 commits interactively
git push --force-with-lease origin <branch> # safe force push (fails if remote changed)
```

## Merge

```sh
git diff --name-only --diff-filter=U       # list files in conflict during merge
```

## Tag

```sh
git tag -d <tag>                           # delete local tag
git push origin :refs/tags/<tag>           # delete remote tag
git tag -a <tag> <commit> -m "msg"         # tag a specific commit
```

## Submodule

```sh
git submodule deinit -f path/to/submodule
rm -rf .git/modules/path/to/submodule
git rm -f path/to/submodule
```

## Fix detached HEAD

```sh
git switch -c temp                         # create branch from detached HEAD
git diff main temp                         # compare
git switch -C main temp                    # update main with temp
git branch -d temp
git push origin
```

## Fzf helpers

```sh
fshow            # git commit browser
fshow_preview    # git commit browser with preview
fcs              # pick commit sha (usage: git rebase -i `fcs`)
fcoc_preview     # checkout commit with preview
```

## Commit types

```
feat      new feature
fix       bug fix
docs      documentation only
style     formatting, no logic change
refactor  code restructure, no behavior change
test      add or fix tests
chore     maintenance, tooling
```
