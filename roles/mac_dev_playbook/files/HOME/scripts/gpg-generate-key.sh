#!/usr/bin/env bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
# set -o xtrace



# This script automates the generation and management of a GPG key.
# It generates a secure password, creates a GPG key, and performs the following tasks:
# 1. Exports the public key to a file.
# 2. Saves the generated password securely in Bitwarden.
# 3. Adds the public key to GitHub using the GitHub CLI.
# 4. Cleans up temporary files and ensures security by unsetting the password variable at the end.

# Generate a secure password for the GPG key
PASSWORD=$(openssl rand -base64 32)
echo "Generated password: $PASSWORD"
echo "Please store this password securely, as it is required to use the GPG key."
echo "Update also the ansible/inventory file with the gpg key id (after 'sec   rsa4096/...')."
echo "Maybe you'll need to comment 'no-tty' in the gpg.conf file."

# Set the GPG_TTY environment variable
export GPG_TTY=$(tty)

# Create the GPG key using the batch configuration file
echo "$PASSWORD" | gpg --pinentry-mode loopback --batch --passphrase-fd 0 --generate-key ~/.gnupg/gpg-key-params.txt

# Confirm success
echo "GPG key generated successfully."
echo "Remember to securely back up your public and private keys if needed."

# Extract the Key ID of the generated GPG key
KEY_ID=$(gpg --list-keys --with-colons | grep '^pub' | tail -n 1 | cut -d':' -f5)

# Export the public key to a file
PUBLIC_KEY_FILE="key.pub"
gpg --armor --export "$KEY_ID" > "$PUBLIC_KEY_FILE"

# Save the generated password to Bitwarden
echo "Saving the password to Bitwarden..."
# Define variables for improved readability
ITEM_NAME="GPG-Key-$KEY_ID"
NOTES="Password for the generated GPG key. Date: $(date)"

# Use the template pattern for creating the item
LOGIN_TEMPLATE=$(bw get template item.login | jq '.username=null | .password=null')
bw get template item | jq \
  --arg name "$ITEM_NAME" \
  --arg notes "$NOTES" \
  --argjson login "$LOGIN_TEMPLATE" \
  '.name=$name | .notes=$notes | .login=$login' \
  | bw encode | bw create item
if [ $? -eq 0 ]; then
    echo "Password successfully saved to Bitwarden."
else
    echo "Failed to save the password to Bitwarden. Please check for errors."
fi
# Add the public key to GitHub using the GitHub CLI
echo "Adding the GPG key to your GitHub account..."
gh gpg-key add "$PUBLIC_KEY_FILE" -t "$KEY_ID"

# Confirm success
if [ $? -eq 0 ]; then
    echo "GPG key successfully added to your GitHub account!"
else
    echo "Failed to add the GPG key to your GitHub account. Please check for errors."
fi

# Cleanup the exported public key file
rm -f "$PUBLIC_KEY_FILE"

# Unset the PASSWORD variable for security
unset PASSWORD
