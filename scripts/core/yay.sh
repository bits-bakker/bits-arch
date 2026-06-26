#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

if command -v yay &>/dev/null; then
    log_info "yay already installed, skipping."
    exit 0
fi

log_header "yay" "Installing AUR helper..."
sudo pacman -S --needed --noconfirm git base-devel
tmpdir=$(mktemp -d)
git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
(cd "$tmpdir/yay" && makepkg -si --noconfirm)
rm -rf "$tmpdir"
log_done "yay installed."
