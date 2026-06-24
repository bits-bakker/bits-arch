#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S --needed --noconfirm \
    pipewire \
    pipewire-alsa \
    pipewire-audio \
    pipewire-jack \
    pipewire-pulse \
    wireplumber \
    pavucontrol
