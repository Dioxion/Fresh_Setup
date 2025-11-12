#!/bin/sh

# Exit on error
set -e

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed."
fi

# Ensure ZSH variable is set (should be set by oh-my-zsh)
if [ -z "$ZSH" ]; then
  echo "ZSH environment variable not set, setting to default location..."
  export ZSH="$HOME/.oh-my-zsh"
fi

# Install plugin into original plugins directory
PLUGIN_DIR="$ZSH/plugins/zsh-autosuggestions"
if [ ! -d "$PLUGIN_DIR" ]; then
  echo "Installing zsh-autosuggestions plugin in $PLUGIN_DIR..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGIN_DIR"
else
  echo "zsh-autosuggestions plugin already present."
fi

# Replace .zshrc with version from repository
echo "Replacing .zshrc with repository version..."
curl -fsSL https://raw.githubusercontent.com/Dioxion/Fresh_Setup/main/Terminal/.zshrc -o "$HOME/.zshrc"

# Replace gnzh theme file in original themes directory
THEME_PATH="$ZSH/themes/gnzh.zsh-theme"
echo "Replacing gnzh.zsh-theme in $THEME_PATH..."
curl -fsSL https://raw.githubusercontent.com/Dioxion/Fresh_Setup/main/Terminal/gnzh.zsh-theme -o "$THEME_PATH"

echo "Setup completed successfully. Please restart your terminal or run 'source ~/.zshrc' to apply changes."
