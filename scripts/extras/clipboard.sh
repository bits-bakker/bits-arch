#!/usr/bin/env bash
set -euo pipefail

# wl-clipboard is installed as a core dependency (needed by hyprpicker, hyprshot)
# This extra adds cliphist for clipboard history
sudo pacman -S --needed --noconfirm cliphist
