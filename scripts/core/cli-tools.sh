#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "cli-tools" "Installing CLI utilities..."
sudo pacman -S --needed --noconfirm \
    bat \
    eza \
    fd \
    fzf \
    imv \
    ripgrep \
    starship \
    fastfetch \
    zoxide
