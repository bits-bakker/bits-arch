#!/usr/bin/env bash
set -euo pipefail

# uwsm starts Hyprland as a proper systemd user session
# sddm is the display manager that presents the login screen
sudo pacman -S --needed --noconfirm uwsm sddm

sudo systemctl enable sddm
