#!/usr/bin/env bash
set -e

PROVISION_HOME="roles/mac_dev_playbook/files/HOME"
PROVISION_ZSHRC="roles/mac_dev_playbook/files/.zshrc.d"

echo "=== Comparing HOME files ==="
cd "$PROVISION_HOME"
find . -type f ! -name ".DS_Store" | while read -r file; do
  target="$HOME/${file#./}"
  if [[ -f "$target" ]]; then
    diff -u "$file" "$target" || true
  else
    echo "Missing: $target"
  fi
done
cd - > /dev/null

echo ""
echo "=== Comparing .zshrc.d files ==="
cd "$PROVISION_ZSHRC"
find . -type f ! -name ".DS_Store" | while read -r file; do
  target="$HOME/.zshrc.d/${file#./}"
  if [[ -f "$target" ]]; then
    diff -u "$file" "$target" || true
  else
    echo "Missing: $target"
  fi
done
cd - > /dev/null
