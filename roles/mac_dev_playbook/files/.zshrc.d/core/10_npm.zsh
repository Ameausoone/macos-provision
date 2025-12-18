#!/usr/bin/env zsh

export PATH="${HOME}/.npm-packages/bin:${PATH}"

# enable auto-completion for npm
source <(npm completion zsh)
