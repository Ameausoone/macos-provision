#!/usr/bin/env zsh


# Aliases for gcloud
# Authenticate
alias g='gcloud'
alias gauth='gcloud auth login --update-adc'
alias gke='gcloud container'
alias gke-list='gcloud container clusters list'
alias gke-credentials='gcloud container clusters get-credentials'

# Autocompletion
# The next line updates PATH for the Google Cloud SDK.
source "$(asdf where gcloud)/path.zsh.inc"

# The next line enables zsh completion for gcloud.
source "$(asdf where gcloud)/completion.zsh.inc"

# Add hpc toolkit to path
export PATH="${HOME}/hpc-toolkit:${PATH}"

# enable hpc autocompletion
eval "$(ghpc completion zsh)"
