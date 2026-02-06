#!/bin/bash 
# A script to install my tools and utilities after Omarchy install

# Root Check - make sure the user is not Root
if [ "$EUID" -eq 0 ]; then
  echo "ERROR: This script cannot be run as root"
  exit 1
fi


# Checking if AUR installer (yay) is installed
if ! command -v yay &> /dev/null; then
  echo "Yay installer not found. You should probably install it mate."
  exit 1
fi


# Tools from the pacman repo
pac_tools=(
  "thunar"
  "thunar-archive-plugin"
  "thunar-volman"
  "thunar-media-tags-plugin"
  "yazi"
  "ghostty"
  "zsh"
  "zsh-syntax-highlighting"
  "zsh-autosuggestions"
  "stow"
  "tmux"
  )

# Tools found in the AUR
aur_tools=(
  "brave-bin"
  "insync"
  "keeper-password-manager"
  )

# Install pacman tools - checking if package in already installed
for pac_tool in "${pac_tools[@]}"; do

  if pacman -Qi "$pac_tool" > /dev/null 2>&1; then
    echo "$pac_tool is already installed. Skipping..."

  else
    echo "Installing $pac_tool..."
    if sudo pacman -S "$pac_tool" --noconfirm; then
      echo "SUCCESS: $pac_tool installed."
    else
      echo "FAILURE: $pac_tool could not be installed. Check the logs."
      continue
    fi
  fi

done


# Install AUR tools - checking if package is already installed
for aur_tool in "${aur_tools[@]}"; do

  if yay -Qi "$aur_tool" > /dev/null 2>&1; then
    echo "$aur_tool is already installed. Skipping..."

  else
    echo "Installing $aur_tool..."
    if yay -S "$aur_tool" --noconfirm; then
      echo "SUCCESS: $aur_tool installed."
    else
      echo "FAILURE: $aur_tool could not be installed. Check the logs."
      continue
    fi
  fi

done

echo "Install complete, unless something got buggered up. In which case you should probably check the logs."

