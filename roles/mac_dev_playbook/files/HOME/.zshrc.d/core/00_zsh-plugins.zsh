#!/usr/bin/env zsh

# zsh-completions: extend fpath before oh-my-zsh runs compinit (01_oh-my-zsh-plugins.zsh)
fpath=("$(brew --prefix)/share/zsh-completions" $fpath)

source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
