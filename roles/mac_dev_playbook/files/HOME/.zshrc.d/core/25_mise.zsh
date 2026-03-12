#!/usr/bin/env zsh

# Enable Mise https://github.com/jdx/mise
# https://mise.jdx.dev/dev-tools/shims.html#shims-vs-path
eval "$(mise activate zsh)"

# Enable auto-completion for Mise
source <(mise completion zsh)

# Load mise.dev.toml configuration file
export MISE_ENV=dev
