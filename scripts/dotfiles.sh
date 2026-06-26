#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES="$REPO_DIR/dotfiles"

stow_pkg() {
    stow --dir="$DOTFILES" --target="$HOME" --restow "$1"
}

log_header "dotfiles" "Linking config files..."
for pkg in hypr waybar mako uwsm walker kitty; do
    log_step "stow: $pkg"
    stow_pkg "$pkg"
done

mkdir -p "$HOME/.config/bits-arch"
echo "aether" > "$HOME/.config/bits-arch/theming"
log_done "Dotfiles linked."
