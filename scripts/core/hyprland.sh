#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "hyprland" "Installing Hyprland and Wayland stack..."
sudo pacman -S --needed --noconfirm \
    hyprland \
    hyprlock \
    hypridle \
    hyprpolkitagent \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal \
    qt5-wayland \
    qt6-wayland
