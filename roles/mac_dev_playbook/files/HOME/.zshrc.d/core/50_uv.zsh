#!/usr/bin/env zsh

# Path for UV tools
export PATH="${HOME}/.local/bin:$PATH"

source <(uv generate-shell-completion zsh)
