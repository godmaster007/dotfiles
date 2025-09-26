#!/usr/bin/env bash

# Fail fast
set -euo pipefail

# GitHub token must be available as an env var
if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "❌ Error: Please export GITHUB_TOKEN before running bootstrap.sh"
  exit 1
fi

# Email used for GitHub key label (change if needed)
GITHUB_EMAIL="your_email@example.com"

# Generate SSH key if missing
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "🔑 Generating new SSH key..."
  mkdir -p ~/.ssh
  ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f ~/.ssh/id_ed25519 -N ""
fi

# Start SSH agent
eval "$(ssh-agent -s)" >/dev/null
ssh-add ~/.ssh/id_ed25519

# Ensure GitHub is in known_hosts
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts 2>/dev/null

# Read public key
PUB_KEY_CONTENT=$(< ~/.ssh/id_ed25519.pub)
KEY_TITLE="$(hostname)-$(date +%Y%m%d%H%M%S)"

# Fetch existing GitHub keys
EXISTING_KEYS=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
                      -H "Accept: application/vnd.github+json" \
                      https://api.github.com/user/keys)

# Check if key is already uploaded
if echo "$EXISTING_KEYS" | grep -q "$PUB_KEY_CONTENT"; then
  echo "✅ SSH key already exists on GitHub, skipping upload."
else
  echo "📤 Uploading SSH key to GitHub with title: $KEY_TITLE"
  curl -s -H "Authorization: token $GITHUB_TOKEN" \
       -H "Accept: application/vnd.github+json" \
       https://api.github.com/user/keys \
       -d "{\"title\":\"$KEY_TITLE\",\"key\":\"$PUB_KEY_CONTENT\"}" \
       | grep -q '"id":' && echo "✅ Key uploaded!" || echo "⚠️ Key upload may have failed"
fi

echo "🎉 GitHub SSH setup complete."