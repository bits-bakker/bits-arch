#!/usr/bin/env bash
set -euo pipefail

# Tools used by keybinds, hypridle, and the Wayland session
sudo pacman -S --needed --noconfirm \
    brightnessctl \
    playerctl \
    power-profiles-daemon \
    ufw \
    wl-clipboard \
    xdg-user-dirs
