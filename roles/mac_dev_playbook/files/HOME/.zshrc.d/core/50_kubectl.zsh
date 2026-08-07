#!/usr/bin/env zsh

source <(kubectl completion zsh)
alias k=kubectl
compdef k=kubectl
