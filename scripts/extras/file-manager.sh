#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "file-manager" "Installing Dolphin file manager..."
sudo pacman -S --needed --noconfirm dolphin
