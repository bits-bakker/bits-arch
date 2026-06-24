#!/usr/bin/env bash
# Called by install.py with: dotfiles.sh <terminal> <launcher>
# Or for switching:          dotfiles.sh --unlink-terminal
#                            dotfiles.sh --link-terminal kitty
set -euo pipefail

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
    --unlink-launcher)
        for l in rofi walker; do
            [[ -d "$DOTFILES/$l" ]] && unstow_pkg "$l"
        done
        ;;
    --link-launcher)
        stow_pkg "${2:?missing launcher name}"
        ;;
    *)
        terminal="${1:?missing terminal}"
        launcher="${2:?missing launcher}"

        # Core configs (always applied)
        for pkg in hypr waybar mako matugen; do
            echo "  stow: $pkg"
            stow_pkg "$pkg"
        done

        # Selected component configs
        echo "  stow: $terminal"
        stow_pkg "$terminal"
        echo "  stow: $launcher"
        stow_pkg "$launcher"

        # GTK CSS doesn't expand ~ — patch the waybar style with the real path
        sed -i "s|@HOME@|$HOME|g" "$HOME/.config/waybar/style.css"
        ;;
esac
