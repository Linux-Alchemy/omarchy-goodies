#!/bin/bash
# A script to install needed virtualization tools



# Root Check - make sure the user is not Root
if [ "$EUID" -eq 0 ]; then
  echo "ERROR: This script cannot be run as root"
  exit 1
fi

# Define packages to be installed
virt_packages=(
  "virt-manager"
  "virt-viewer"
  "libvirt"
  "edk2-ovmf"
  "dnsmasq"
  "dmidecode"
  )

# Install virtualization tools - checking if package is already installed
for virt_package in "${virt_packages[@]}"; do

  if pacman -Qi "$virt_package" > /dev/null 2>&1; then
    echo "$virt_package is already installed. Skipping..."

  else
    echo "Installing $virt_package..."
    if sudo pacman -S "$virt_package" --noconfirm; then
      echo "SUCCESS: $virt_package installed."
    else
      echo "FAILURE: $virt_package could not be installed. Check the logs."
      continue
    fi
  fi

done

# Adding user to the libvirt group
echo "Adding $USER to 'libvirt' group..."
sudo usermod -aG libvirt "$USER"

echo "Install complete. Unless something buggered up, in which case you should check the logs."
echo "You will need to reboot for the group change to take effect."


