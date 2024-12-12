#!/usr/bin/env bash

# Generate a secure password for the GPG key
# Using OpenSSL to create a 32-character base64-encoded string
PASSWORD=$(openssl rand -base64 32)
echo "Generated password: $PASSWORD"
echo "Please store this password securely, as it is required to use the GPG key."
echo "Update also the ansible/inventory file with the gpg key id (after 'sec   rsa4096/...')"

# Set the GPG_TTY environment variable
# This ensures GPG knows which terminal to use for interaction
export GPG_TTY=$(tty)

# Create the GPG key using the batch configuration file
# The `--batch` flag ensures the process is non-interactive
# The `--passphrase-fd 0` reads the passphrase from the input (piped echo command)
# The `--pinentry-mode loopback` forces GPG to use the terminal for passphrase input
echo "$PASSWORD" | gpg --pinentry-mode loopback --batch --passphrase-fd 0 --generate-key ~/.gnupg/gpg-key-params.txt

# Unset the PASSWORD variable for security
# This prevents the password from remaining in the environment after the script ends
unset PASSWORD

# Confirm success and remind the user to back up their key
echo "GPG key generated successfully."
echo "Remember to securely back up your public and private keys if needed."
