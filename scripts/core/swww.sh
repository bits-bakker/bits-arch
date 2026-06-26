#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "swww" "Installing wallpaper daemon..."
sudo pacman -S --needed --noconfirm swww
