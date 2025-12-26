#!/bin/bash

ORIGINAL_DIR=$(pwd)
REPO_URL="https://github.com/Linux-Alchemy/dotfiles.git"
REPO_NAME="dotfiles"


if [[ "$(pwd -P)" != "$HOME" ]]; then
  cd ~
fi

# Checking if STOW installed 
is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Stow is not installed. You should probably do that first. Goodbye."
  exit 1
fi


# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  echo "Clone sucessful. So far so good..."
else
  echo "Failed to clone the repository. Goodbye."
  exit 1
fi


# Targets for removal and replacement
TARGETS=(
  "$HOME/.bashrc"
  "$HOME/.zshrc"
  "$HOME/.config/hypr/bindings.conf"
  "$HOME/.config/hypr/input.conf"
  "$HOME/.config/hypr/monitors.conf"
  "$HOME/.config/starship.toml"
  "$HOME/.config/ghostty/config"
  "$HOME/.config/alacritty/alacritty.toml"
  "$HOME/.config/waybar/config.jsonc"
  "$HOME/.config/waybar/style.css"
  )

# Clear the way for STOW 
for target in "${TARGETS[@]}"; do
  if [ -e "$target" ]; then
    echo "Removing $target"
    rm -rf "$target"
  fi
done


PACKAGES=(
  "hypr"
  "shell"
  "terminals"
  "waybar"
  )

cd "$REPO_NAME"

for pkg in "${PACKAGES[@]}"; do
  echo "Stowing $pkg..."
  stow -v -t ~ "$pkg"
done

echo "All configs installed...probably."


