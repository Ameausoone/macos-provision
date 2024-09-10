#!/usr/bin/env zsh

alias gcml="gcm && gl"

### Editor ###
export EDITOR='idea -e --wait'

function gcamp() {
  git commit -am "$1"
  git push
}
