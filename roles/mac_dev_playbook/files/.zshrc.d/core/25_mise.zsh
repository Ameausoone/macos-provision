#!/usr/bin/env zsh

# Enable Mise https://github.com/jdx/mise
# https://mise.jdx.dev/dev-tools/shims.html#shims-vs-path

# Setup completions if not already present
if [[ ! -f /usr/local/share/zsh/site-functions/_mise ]]; then
  mise completion zsh > /usr/local/share/zsh/site-functions/_mise 2>/dev/null
fi

eval "$(mise activate zsh)"
