#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "bluetooth" "Installing Bluetooth support..."
sudo pacman -S --needed --noconfirm bluez bluez-utils blueman
sudo systemctl enable bluetooth
log_done "Bluetooth enabled."
