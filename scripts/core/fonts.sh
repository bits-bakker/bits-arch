#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S --needed --noconfirm \
    ttf-jetbrains-mono-nerd \
    ttf-nerd-fonts-symbols \
    noto-fonts \
    noto-fonts-emoji
