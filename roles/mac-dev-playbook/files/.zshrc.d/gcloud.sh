#!/usr/bin/env zsh

alias gclo="gcloud"
alias gcloalu="gcloud auth login --update-adc"

# Autocompletion
# The next line updates PATH for the Google Cloud SDK.
source "$(asdf where gcloud)/path.zsh.inc"

# The next line enables zsh completion for gcloud.
source "$(asdf where gcloud)/completion.zsh.inc"
