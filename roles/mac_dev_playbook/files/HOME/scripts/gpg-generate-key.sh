#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

# Generates a GPG key, updates ~/.gitconfig.local signingkey, and adds the key to GitHub.

PASSWORD=$(openssl rand -base64 32)
export GPG_TTY=$(tty)

echo "==> Generating GPG key..."
echo "$PASSWORD" | gpg --pinentry-mode loopback --batch --passphrase-fd 0 --generate-key ~/.gnupg/gpg-key-params.txt

KEY_ID=$(gpg --list-keys --with-colons | grep '^pub' | tail -n 1 | cut -d':' -f5)
echo "==> Key ID: $KEY_ID"

echo "==> Passphrase (store securely):"
echo "    $PASSWORD"

echo "==> Updating ~/.gitconfig.local signingkey..."
gsed -i.bak "/signingkey/c\  signingkey = ${KEY_ID}" ~/.gitconfig.local

PUBLIC_KEY_FILE=$(mktemp /tmp/gpg-key.XXXXXX.pub)
gpg --armor --export "$KEY_ID" > "$PUBLIC_KEY_FILE"

echo "==> Adding GPG key to GitHub..."
if gh gpg-key add "${PUBLIC_KEY_FILE}" -t "${KEY_ID}"; then
    echo "==> Done. Key $KEY_ID added to GitHub."
else
    echo "ERROR: failed to add key to GitHub."
fi

rm -f "$PUBLIC_KEY_FILE"
unset PASSWORD
