#!/bin/bash

# Exit on error
set -e

# Current directory where dotfiles repo is cloned
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing dotfiles via GNU Stow from $DOTFILES_DIR..."

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "Error: 'stow' is not installed. Please install it first."
    exit 1
fi

# Ensure some folders exists
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"

# Run stow for the packages
# -t ~      : target home directory
# -v        : verbose
# -R        : restow (unlinks and relinks, good for updates)
stow -t "$HOME" -v -R home
stow -t "$HOME/.config" -v -R config
stow -t "$HOME/.local" -v -R local

echo "✅ Dotfiles installation complete!"
