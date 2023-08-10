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

# WARNING: ghpc binary was built from a different commit (main/8bac6ec) than the current git branch in /Users/ANTOINE/hpc-toolkit (main/f7abfbe). You can rebuild the binary by running 'make'
# enable hpc autocompletion
eval "$(ghpc completion zsh 2> /dev/null)"

# cf https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke?hl=en
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
