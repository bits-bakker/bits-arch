#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "stow" "Installing GNU stow..."
sudo pacman -S --needed --noconfirm stow
