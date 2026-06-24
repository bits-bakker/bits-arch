#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S --needed --noconfirm \
    bat \
    eza \
    fd \
    fzf \
    imv \
    ripgrep \
    starship \
    fastfetch \
    zoxide
