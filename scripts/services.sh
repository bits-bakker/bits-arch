#!/usr/bin/env bash
set -euo pipefail

systemctl --user enable --now pipewire pipewire-pulse wireplumber
systemctl --user enable hypridle
