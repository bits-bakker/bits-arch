#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log_header "post-install" "Setting up XDG user directories..."
xdg-user-dirs-update
mkdir -p ~/Downloads ~/Pictures/Screenshots ~/Pictures/Wallpapers ~/Videos ~/Projects

log_header "post-install" "Setting GTK dark theme..."
gsettings set org.gnome.desktop.interface gtk-theme    "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"
gsettings set org.gnome.desktop.interface icon-theme   "Adwaita"

log_header "post-install" "Configuring firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force enable
sudo systemctl enable ufw

log_header "post-install" "Creating waybar CSS fallback..."
mkdir -p ~/.config/waybar
touch ~/.config/waybar/matugen.css

log_done "Post-install setup complete."
