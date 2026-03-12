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
source "$(mise where gcloud)/path.zsh.inc"

# The next line enables zsh completion for gcloud.
source "$(mise where gcloud)/completion.zsh.inc"

# cf https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke?hl=en
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
