#!/usr/bin/env zsh

# Enable fnox shell integration
# fnox is a tool to load secrets automatically, integrated with mise
# https://fnox.jdx.dev/
#eval "$(fnox activate zsh)"

export FNOX_SHELL=zsh

fnox() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    ~/.local/share/mise/installs/fnox/latest/fnox
    return
  fi
  shift

  case "$command" in
  deactivate|shell)
    eval "$(~/.local/share/mise/installs/fnox/latest/fnox "$command" "$@")"
    ;;
  *)
    ~/.local/share/mise/installs/fnox/latest/fnox "$command" "$@"
    ;;
  esac
}

_fnox_hook() {
  trap -- '' SIGINT
  eval "$(~/.local/share/mise/installs/fnox/latest/fnox hook-env -s zsh)"
  trap - SIGINT
}

typeset -ag precmd_functions
if [[ -z "${precmd_functions[(r)_fnox_hook]+1}" ]]; then
  precmd_functions=( _fnox_hook ${precmd_functions[@]} )
fi

typeset -ag chpwd_functions
if [[ -z "${chpwd_functions[(r)_fnox_hook]+1}" ]]; then
  chpwd_functions=( _fnox_hook ${chpwd_functions[@]} )
fi
