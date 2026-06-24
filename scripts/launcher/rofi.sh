#!/usr/bin/env bash
set -euo pipefail

# rofi-wayland is the Wayland fork; conflicts with rofi (X11)
sudo pacman -S --needed --noconfirm rofi-wayland
