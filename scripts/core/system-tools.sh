#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "system-tools" "Installing system utilities..."
sudo pacman -S --needed --noconfirm \
    brightnessctl \
    playerctl \
    power-profiles-daemon \
    ufw \
    wl-clipboard \
    xdg-user-dirs
