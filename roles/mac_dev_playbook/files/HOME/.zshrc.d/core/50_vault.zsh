#!/usr/bin/env zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C "$(brew --prefix)/bin/vault" vault
