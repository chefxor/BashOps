#!/bin/bash

# Install Zsh
pacman -S --noconfirm zsh

# Clone essential plugins
ZSH_PLUGIN_DIR="$HOME/.zsh/plugins"
mkdir -p "$ZSH_PLUGIN_DIR"

git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGIN_DIR/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-completions "$ZSH_PLUGIN_DIR/zsh-completions"

# Reload Zsh config
source ~/.zshrc

# Ask to change default shell
read -p "Change default shell to Zsh? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    read -p "Enter username (press Enter for '$USER'): " username
    chsh -s "$(command -v zsh)" "${username:-$USER}"
fi
