#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "mako" "Installing notification daemon..."
sudo pacman -S --needed --noconfirm mako libnotify
