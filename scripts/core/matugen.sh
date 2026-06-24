#!/usr/bin/env bash
set -euo pipefail

# matugen is in the AUR; install yay first if needed
if ! command -v yay &>/dev/null; then
    echo "Installing yay (AUR helper)..."
    sudo pacman -S --needed --noconfirm git base-devel
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    (cd "$tmpdir/yay" && makepkg -si --noconfirm)
    rm -rf "$tmpdir"
fi

yay -S --needed --noconfirm matugen-bin
