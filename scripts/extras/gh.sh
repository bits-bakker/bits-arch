#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "gh" "Installing GitHub CLI..."
sudo pacman -S --needed --noconfirm github-cli
