#!/usr/bin/env zsh

# gh completion is loaded via the static _gh file in $(brew --prefix)/share/zsh/site-functions
# (see 00_zsh-plugins.zsh)

alias ghprv="gh pr view --web"

# use to send gh output to cat instead of less, which is the default pager for gh
export GH_PAGER='cat'
