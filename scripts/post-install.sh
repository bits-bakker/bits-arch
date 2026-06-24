#!/usr/bin/env bash
# Runs after packages + dotfiles are in place.
# Sets up user directories, GTK theme, firewall, and cache fallbacks.
set -euo pipefail

echo "[post-install] Setting up XDG user directories..."
xdg-user-dirs-update
mkdir -p ~/Downloads ~/Pictures/Screenshots ~/Pictures/Wallpapers ~/Videos ~/Projects

echo "[post-install] Setting GTK dark theme..."
gsettings set org.gnome.desktop.interface gtk-theme     "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme  "prefer-dark"
gsettings set org.gnome.desktop.interface cursor-theme  "Adwaita"
gsettings set org.gnome.desktop.interface icon-theme    "Adwaita"

echo "[post-install] Configuring firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force enable
sudo systemctl enable ufw

echo "[post-install] Creating matugen cache fallbacks..."
mkdir -p ~/.cache/matugen
# Empty fallback files prevent Hyprland/apps from erroring on first boot
# before set-wallpaper.sh is run for the first time
for f in hyprland-colors.conf hyprlock-colors.conf waybar-colors.css \
          rofi-colors.rasi kitty-colors.conf foot-colors.ini mako-colors.ini; do
    touch ~/.cache/matugen/"$f"
done
