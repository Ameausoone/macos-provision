#!/usr/bin/env zsh

# Enable Mise https://github.com/jdx/mise
# https://mise.jdx.dev/dev-tools/shims.html#shims-vs-path
eval "$(mise activate zsh)"

# mise completion is loaded via the static _mise file in
# $(brew --prefix)/share/zsh/site-functions (see 00_zsh-plugins.zsh)

# Load mise.dev.toml configuration file
export MISE_ENV=dev
