#!/usr/bin/env zsh

alias gcml="gcm && gl"

### Editor ###
export EDITOR='idea -e --wait'

export GITHUB_EMAIL="592978+Ameausoone@users.noreply.github.com"

# generate ssh-key
alias gen-ssh-key="ssh-keygen -t ed25519 -C ${GITHUB_EMAIL}"

function gcamp() {
  git commit -am "$1"
  git push
}
