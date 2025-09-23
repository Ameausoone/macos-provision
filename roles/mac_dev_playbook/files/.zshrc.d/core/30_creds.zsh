#!/usr/bin/env zsh

# Credential management functions for macOS keychain
# These functions provide secure storage and retrieval of secrets using the system keychain

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

# Create or update a secret in the keychain
# Usage: creds_upsert_local_secret <domain> <secret>
# Returns: 0 on success, 1 on failure
function creds_upsert_local_secret(){
  if [[ "$#" -ne 2 ]]; then
    echo "Usage : creds_upsert_local_secret <domain> <secret>, will create or update a secret in the keychain"
    echo "⛈️ ERROR ⛈️: creds_upsert_local_secret requires exactly 2 arguments, got $#"
    return 1
  fi
  local domain=$1
  local secret=$2
  echo "  ~> Specify secret for $domain.$secret"
  read -r entry

  # Validate that the secret is not empty
  if [[ -z "$entry" ]]; then
    echo "⛈️ ERROR ⛈️: Secret cannot be empty"
    return 1
  fi

  local keychain_entry="$domain.$secret"
  # Check if keychain entry exists (returns 0 if found, 44 if not found)
  if security find-generic-password -a "${LOGNAME}" -s "${keychain_entry}" > /dev/null 2>&1; then
    echo "  ~> Update $keychain_entry"
    if ! security delete-generic-password -a "${LOGNAME}" -s "${keychain_entry}" 2>/dev/null; then
      echo "⛈️ ERROR ⛈️: Failed to delete existing keychain entry"
      return 1
    fi
    if ! security add-generic-password -a "${LOGNAME}" -w "${entry}" -s "${keychain_entry}" 2>/dev/null; then
      echo "⛈️ ERROR ⛈️: Failed to update keychain entry"
      return 1
    fi
  else
    echo "  ~> Create $keychain_entry"
    if ! security add-generic-password -a "${LOGNAME}" -w "${entry}" -s "${keychain_entry}" 2>/dev/null; then
      echo "⛈️ ERROR ⛈️: Failed to create keychain entry"
      return 1
    fi
  fi
  echo "Now call \$\(creds_get_local_secret \"\$domain\" \"\$secret\"\) to get the secret."
}

# Retrieve a secret from the keychain
# Usage: creds_get_local_secret <domain> <secret>
# Returns: 0 on success, 1 on failure
function creds_get_local_secret(){
  if [[ $# -ne 2 ]]; then
    echo "⛈️ ERROR ⛈️: creds_get_local_secret requires 2 arguments, got $#"
    return 1
  fi
  local domain=$1
  local secret=$2
  local keychain_entry="$domain.$secret"

  if ! security find-generic-password -a "${LOGNAME}" -s "${keychain_entry}" -w 2>/dev/null; then
    echo "⛈️ ERROR ⛈️: creds_get_local_secret failed to find ${keychain_entry}" >&2
    return 1
  fi
}

# Delete a secret from the keychain
# Usage: creds_delete_local_secret <domain> <secret>
# Returns: 0 on success, 1 on failure
function creds_delete_local_secret(){
  if [[ $# -ne 2 ]]; then
    echo "⛈️ ERROR ⛈️: creds_delete_local_secret requires 2 arguments, got $#"
    return 1
  fi
  local domain=$1
  local secret=$2
  local keychain_entry="$domain.$secret"

  if ! security delete-generic-password -a "${LOGNAME}" -s "${keychain_entry}" 2>/dev/null; then
    echo "⛈️ ERROR ⛈️: Failed to delete keychain entry ${keychain_entry}" >&2
    return 1
  fi
  echo "  ~> Deleted $keychain_entry"
}
