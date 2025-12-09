#!/bin/bash

ORIGINAL_DIR=$(pwd)
REPO_URL="https://github.com/Linux-Alchemy/omarchy-goodies/tree/master/dotfiles"
REPO_NAME="dotfiles"

is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

cd ~

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  echo "Backing up original files..."
  cp ~/.config/hypr/bindings.conf bindingsndings.conf.bak
  cp ~/.config/hypr/input.conf input.conf.bak
  cp ~/.config/hypr/monitors.conf monitors.conf.bak
  cp ~/.config/starship.toml starship.toml.bak
  cp ~/.bashrc .bashrc.bak
  cp ~/.zshrc .zshrc.bak
  cp ~/.config/alacritty/alacritty.toml alacritty.toml.bak
  cp ~/.config/ghostty/config config.bak
  cp ~/.config/waybar/config.jsonc config.jsonc.bak
  cp ~//config/waybar/style.css style.css.bak
  echo "Original files backup complete."

  cd "$REPO_NAME"
  stow hypr
  stow shell
  stow terminals
  stow waybar
 
else
  echo "Failed to clone the repository."
  exit 1
fi
