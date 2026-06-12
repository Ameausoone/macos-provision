#!/usr/bin/env zsh

eval "$(gh completion --shell zsh)"

alias ghprv="gh pr view --web"

# use to send gh output to cat instead of less, which is the default pager for gh
export GH_PAGER='cat'
