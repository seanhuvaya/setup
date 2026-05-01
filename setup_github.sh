#!/bin/bash
# =============================================================================
# Git + SSH Setup Script
# Usage: ./setup-git.sh "Your Name" your.email@example.com
# =============================================================================

set -euo pipefail

if [ $# -ne 2 ]; then
    echo "Usage: $0 \"Your Full Name\" your.email@example.com"
    echo "Example: $0 \"John Doe\" john.doe@example.com"
    exit 1
fi

NAME="$1"
EMAIL="$2"

echo "=== Setting up Git and SSH for ==="
echo "Name : $NAME"
echo "Email: $EMAIL"
echo

# 1. Configure Git globally
echo "Configuring Git..."
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global init.defaultBranch main

echo "Git configured successfully."
echo

# 2. Create SSH key (Ed25519 - modern & secure)
KEY_PATH="$HOME/.ssh/github_ed25519"

if [ -f "$KEY_PATH" ]; then
    echo "SSH key already exists at $KEY_PATH"
    echo "Skipping key generation."
else
    echo "Generating new Ed25519 SSH key..."
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
    echo "SSH key generated at $KEY_PATH"
fi

echo

# 3. Copy public key to clipboard (cross-platform)
PUB_KEY="$KEY_PATH.pub"

if [ ! -f "$PUB_KEY" ]; then
    echo "Error: Public key not found!"
    exit 1
fi

echo "Copying public key to clipboard..."

# macOS
pbcopy < "$PUB_KEY"
echo "✅ Public key copied to clipboard (macOS pbcopy)"

echo
echo "=== Setup Complete! ==="
echo
echo "Next steps:"
echo "1. Paste the key (already in clipboard) into GitHub / GitLab / Bitbucket → SSH keys"
echo "2. Test with: ssh -T git@github.com"
echo
cat "$PUB_KEY"
