#!/usr/bin/env zsh

# Had to add this to get asdf to work on my mac

source "$(brew --prefix asdf)/libexec/asdf.sh"

## Some functions to help
function _asdf_install_plugin() {
  local ASDF_TOOLS_VERSIONS_FILENAME="$HOME/.tool-versions"
  for plugin in $(awk '{print $1}' ${ASDF_TOOLS_VERSIONS_FILENAME}); do \
    asdf plugin add "$plugin" || true; \
  done
}

function asdf_install_version() {
  _asdf_install_plugin
  local ASDF_TOOLS_VERSIONS_FILENAME="$HOME/.tool-versions"
  cat "${ASDF_TOOLS_VERSIONS_FILENAME}" | while read -r plugin version; do \
    asdf install "${plugin}" "${version}"; \
  done
}
