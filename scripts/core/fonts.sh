#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "fonts" "Installing fonts..."
sudo pacman -S --needed --noconfirm \
    ttf-jetbrains-mono-nerd \
    ttf-nerd-fonts-symbols \
    noto-fonts \
    noto-fonts-emoji
