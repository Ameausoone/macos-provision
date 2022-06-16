#!/usr/bin/env zsh

alias gclo="gcloud"
alias gcloalu="gcloud auth login --update-adc"

# Autocompletion
# FIXME
# The next line updates PATH for the Google Cloud SDK.
source /Users/ANTOINE/.asdf/installs/gcloud/390.0.0/path.zsh.inc

# The next line enables zsh completion for gcloud.
source /Users/ANTOINE/.asdf/installs/gcloud/390.0.0/completion.zsh.inc
