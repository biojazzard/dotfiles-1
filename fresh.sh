#!/bin/sh

set -e

echo "Setting up Mac..."

# Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  exit 1
fi

# Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no \
  CHSH=no \
  /bin/sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Dotfiles zshrc
rm -f "$HOME/.zshrc"
ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"

# Homebrew dependencies
brew update
brew bundle --file "$HOME/.dotfiles/Brewfile"

# Development directory
mkdir -p "$HOME/Code"

echo "Base setup complete."
