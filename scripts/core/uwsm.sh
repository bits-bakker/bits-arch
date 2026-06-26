#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "uwsm" "Installing session manager and display manager..."
sudo pacman -S --needed --noconfirm uwsm sddm
sudo systemctl enable sddm
