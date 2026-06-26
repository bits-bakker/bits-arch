#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "waybar" "Installing status bar..."
sudo pacman -S --needed --noconfirm waybar
