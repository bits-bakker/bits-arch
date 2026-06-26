#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

if ! command -v yay &>/dev/null; then
    log_error "yay not found. Run core/yay.sh first."
    exit 1
fi

log_header "launcher" "Installing Walker launcher..."
yay -S --needed --noconfirm walker-bin
