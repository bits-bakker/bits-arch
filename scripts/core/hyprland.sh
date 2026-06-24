#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S --needed --noconfirm \
    hyprland \
    hyprlock \
    hypridle \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal \
    polkit-gnome \
    qt5-wayland \
    qt6-wayland
