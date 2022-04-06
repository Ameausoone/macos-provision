#!/bin/zsh

alias browse="g config --get remote.origin.url | gsed -r -e 's/git@github\.com:(\w+)\/(.*)(:\.git)?/https:\/\/github.com\/\1\/\2/g' | xargs open"

alias gcml="gcm && gl"

### Editor ###
export EDITOR='code --wait'