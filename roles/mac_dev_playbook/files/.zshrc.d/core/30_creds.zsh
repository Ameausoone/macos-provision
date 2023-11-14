#!/usr/bin/env zsh

# Check cli requirements
function check_cli_requirements () {
  echo "  ~> Check requirements"
  if [[ -z "$(which jq)" ]]; then
    echo "  ~> Install jq"
    return 1
  fi
  if [[ -z "$(which gcloud)" ]]; then
    echo "  ~> Install gcloud"
    return 1
  fi
}

# Upsert a secret in the keychain
function creds_upsert_local_secret(){
  if [[ "$#" -lt 2 ]]; then
    echo "Usage : creds_upsert_local_secret <domain> <secret> [entry], will create or update a secret in the keychain"
    echo "⛈️ ERROR ⛈️: creds_upsert_local_secret requires 3 arguments, arguments : ${@}"
    return 1
  fi
  local domain=$1
  local secret=$2
  if [[ "$#" -eq 3 ]]; then
    local entry="$3"
  else
    echo "  ~> Enter $domain.$secret"
    read -r entry
  fi
  local keychain_entry="$domain.$secret"
  # security find-generic-password -a $LOGNAME -s $keychain_entry return 0 if found, 44 if not found
  if security find-generic-password -a "${LOGNAME}" -s "${keychain_entry}" > /dev/null 2>&1; then
    echo "  ~> Update $keychain_entry"
    security delete-generic-password -a "${LOGNAME}" -s "${keychain_entry}"
    security add-generic-password -a "${LOGNAME}" -w "${entry}" -s "${keychain_entry}"
  else
    echo "  ~> Create $keychain_entry"
    security add-generic-password -a "${LOGNAME}" -w "${entry}" -s "${keychain_entry}"
  fi
}

# Get a secret from the keychain
function creds_get_local_secret(){
  if [[ $# -ne 2 ]]; then
    echo "⛈️ ERROR ⛈️: creds_get_local_secret requires 2 arguments, got $#"
    return 1
  fi
  local domain=$1
  local secret=$2
  local keychain_entry="$domain.$secret"
  security find-generic-password -a "${LOGNAME}" -s "${keychain_entry}" -w
  if [[ $? -ne 0 ]]; then
    echo "⛈️ ERROR ⛈️: _cpe_get_local_secret failed to find ${keychain_entry}"
    return 1
  fi
}
