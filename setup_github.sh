#!/bin/bash
# =============================================================================
# Git + SSH Setup Script for macOS (Fixed Version)
# Usage: ./setup-git.sh "Your Name" your.email@example.com
# =============================================================================
set -euo pipefail

if [ $# -ne 2 ]; then
    echo "Usage: $0 \"Your Full Name\" your.email@example.com"
    echo "Example: $0 \"Sean\" your.email@example.com"
    exit 1
fi

NAME="$1"
EMAIL="$2"

echo "=== Setting up Git and SSH for GitHub ==="
echo "Name : $NAME"
echo "Email: $EMAIL"
echo

# 1. Configure Git globally
echo "Configuring Git..."
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global init.defaultBranch main
echo "✅ Git configured successfully."
echo

# 2. SSH Key Path
KEY_PATH="$HOME/.ssh/github_ed25519"
PUB_KEY="$KEY_PATH.pub"

# 3. Create SSH key if it doesn't exist
if [ -f "$KEY_PATH" ]; then
    echo "SSH key already exists at $KEY_PATH"
else
    echo "Generating new Ed25519 SSH key..."
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
    echo "✅ SSH key generated."
fi
echo

# 4. Set correct permissions
echo "Setting secure permissions..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
chmod 600 "$KEY_PATH" 2>/dev/null || true
chmod 644 "$PUB_KEY" 2>/dev/null || true
echo "✅ Permissions set."
echo

# 5. Add key to ssh-agent with macOS Keychain
echo "Adding SSH key to agent..."
eval "$(ssh-agent -s)" >/dev/null 2>&1
ssh-add --apple-use-keychain "$KEY_PATH" 2>/dev/null || true
echo "✅ Key added to ssh-agent."
echo

# 6. Create/Update ~/.ssh/config (FIXED - variables now expand correctly)
echo "Creating SSH config for GitHub..."
cat > "$HOME/.ssh/config" << EOF
Host github.com
    HostName github.com
    User git
    IdentityFile ${KEY_PATH}
    AddKeysToAgent yes
    UseKeychain yes
    IdentitiesOnly yes
EOF

chmod 600 "$HOME/.ssh/config"
echo "✅ ~/.ssh/config created successfully."
echo

# 7. Copy public key to clipboard
echo "Copying public key to clipboard..."
pbcopy < "$PUB_KEY"
echo "✅ Public key copied to clipboard!"
echo

# Final message
echo "=== Setup Complete! ==="
echo
echo "Next steps:"
echo "1. Go to GitHub → Settings → SSH and GPG keys → New SSH key"
echo "2. Paste the key from your clipboard"
echo "3. Test with:"
echo "   ssh -T git@github.com"
echo
echo "Your public key:"
cat "$PUB_KEY"
