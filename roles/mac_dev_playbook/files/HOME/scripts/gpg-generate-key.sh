#!/usr/bin/env bash

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

# Unset the PASSWORD variable for security
unset PASSWORD

# Confirm success
echo "GPG key generated successfully."
echo "Remember to securely back up your public and private keys if needed."

# Extract the Key ID of the generated GPG key
KEY_ID=$(gpg --list-keys --with-colons | grep '^pub' | tail -n 1 | cut -d':' -f5)

# Export the public key to a file
PUBLIC_KEY_FILE="key.pub"
gpg --armor --export "$KEY_ID" > "$PUBLIC_KEY_FILE"

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
