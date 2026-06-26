#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log_header "services" "Enabling audio services..."
systemctl --user enable --now pipewire pipewire-pulse wireplumber

log_step "hypridle (idle management)"
systemctl --user enable hypridle

log_step "power-profiles-daemon"
sudo systemctl enable --now power-profiles-daemon

log_step "swayosd-server (volume/brightness OSD)"
systemctl --user enable --now swayosd-server

log_done "Services enabled."
