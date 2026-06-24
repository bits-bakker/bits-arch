#!/usr/bin/env bash
set -euo pipefail

# Audio
systemctl --user enable --now pipewire pipewire-pulse wireplumber

# Idle management
systemctl --user enable hypridle

# Power profiles (enables power-profiles-daemon for battery/performance switching)
sudo systemctl enable --now power-profiles-daemon

# swayosd server (volume/brightness on-screen display)
systemctl --user enable --now swayosd-server
