#!/usr/bin/env bash
# Called by install.py with: dotfiles.sh <terminal>
# Or for switching:          dotfiles.sh --unlink-terminal
#                            dotfiles.sh --link-terminal <name>
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES="$REPO_DIR/dotfiles"

stow_pkg() {
    stow --dir="$DOTFILES" --target="$HOME" --restow "$1"
}

unstow_pkg() {
    stow --dir="$DOTFILES" --target="$HOME" --delete "$1" 2>/dev/null || true
}

case "${1:-}" in
    --unlink-terminal)
        for t in kitty foot ghostty; do
            [[ -d "$DOTFILES/$t" ]] && unstow_pkg "$t"
        done
        ;;
    --link-terminal)
        stow_pkg "${2:?missing terminal name}"
        ;;
    *)
        terminal="${1:?missing terminal}"

        log_header "dotfiles" "Linking config files..."
        for pkg in hypr waybar mako uwsm walker; do
            log_step "stow: $pkg"
            stow_pkg "$pkg"
        done

        log_step "stow: $terminal"
        stow_pkg "$terminal"

        mkdir -p "$HOME/.config/bits-arch"
        echo "aether" > "$HOME/.config/bits-arch/theming"
        log_done "Dotfiles linked."
        ;;
esac
