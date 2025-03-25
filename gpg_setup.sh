#!/bin/bash

# Start interactive GPG key generation
echo "Starting GPG key generation..."
gpg --full-generate-key

# List available secret keys
echo "Available GPG secret keys:"
gpg --list-secret-keys --keyid-format=long

# Prompt user to enter the key ID
read -p "Enter the GPG key ID to use for signing (from above list): " KEY_ID

# Configure Git to use this key and sign commits by default
git config --global user.signingkey $KEY_ID
git config --global commit.gpgsign true

echo "Git has been configured to sign all commits with GPG key: $KEY_ID"
