#!/bin/bash

# Install all packages

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/install-omarchypkg.sh"
"$SCRIPT_DIR/install-dotfiles.sh"
"$SCRIPT_DIR/install-hyprland-overrides.sh"

