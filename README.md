# bits-arch

Opinionated Hyprland setup for Arch Linux. Run after a fresh `archinstall` minimal-profile install.

## Usage

```bash
git clone https://github.com/bits-bakker/bits-arch ~/bits-arch
cd ~/bits-arch
bash install.sh          # full install
bash install.sh --apps   # open the optional application installer
```

## What gets installed

### AUR helper

| Package | Source | Purpose |
|---|---|---|
| yay | AUR (built from source) | AUR helper — required for AUR packages below |

### Hyprland & Wayland

| Package | Source | Purpose |
|---|---|---|
| hyprland | pacman | Wayland compositor |
| hyprlock | pacman | Lock screen |
| hypridle | pacman | Idle management |
| hyprpolkitagent | pacman | Polkit authentication agent |
| hyprsunset | pacman | Blue light filter |
| hyprpicker | AUR | Color picker |
| xdg-desktop-portal-hyprland | pacman | XDG portal (screen sharing, file picker) |
| xdg-desktop-portal | pacman | XDG portal base |
| qt5-wayland | pacman | Qt5 Wayland support |
| qt6-wayland | pacman | Qt6 Wayland support |
| uwsm | pacman | Systemd session manager for Hyprland |
| sddm | pacman | Display / login manager |

### Audio

| Package | Source | Purpose |
|---|---|---|
| pipewire | pacman | Audio server |
| pipewire-alsa | pacman | ALSA compatibility |
| pipewire-audio | pacman | Audio session support |
| pipewire-jack | pacman | JACK compatibility |
| pipewire-pulse | pacman | PulseAudio compatibility |
| wireplumber | pacman | PipeWire session manager |
| pavucontrol | pacman | Audio control GUI |

### Desktop shell

| Package | Source | Purpose |
|---|---|---|
| waybar | pacman | Status bar |
| mako | pacman | Notification daemon |
| libnotify | pacman | Desktop notification library |
| swww | pacman | Wallpaper daemon |
| swayosd-git | AUR | Volume / brightness on-screen display |

### Screenshots

| Package | Source | Purpose |
|---|---|---|
| hyprshot | pacman | Screenshot capture (screen / window) |
| satty | AUR | Screenshot annotation (region capture) |

### Terminal & launcher

| Package | Source | Purpose |
|---|---|---|
| kitty | pacman | Terminal emulator |
| walker-bin | AUR | Application launcher |

### Theming

| Package | Source | Purpose |
|---|---|---|
| aether-bin | AUR | Theme engine (preset themes: dracula, nord, gruvbox, catppuccin, sakura, rose-pine) |

### System tools

| Package | Source | Purpose |
|---|---|---|
| brightnessctl | pacman | Backlight control |
| playerctl | pacman | Media player control |
| power-profiles-daemon | pacman | Battery / performance profiles |
| ufw | pacman | Firewall |
| wl-clipboard | pacman | Wayland clipboard |
| xdg-user-dirs | pacman | XDG user directory management |
| stow | pacman | Dotfile symlink manager |

### Fonts

| Package | Source | Purpose |
|---|---|---|
| ttf-jetbrains-mono-nerd | pacman | Primary monospace font |
| ttf-nerd-fonts-symbols | pacman | Icon symbols |
| noto-fonts | pacman | Wide Unicode coverage |
| noto-fonts-emoji | pacman | Emoji support |

### CLI utilities

| Package | Source | Purpose |
|---|---|---|
| bat | pacman | `cat` with syntax highlighting |
| eza | pacman | Modern `ls` replacement |
| fd | pacman | Fast `find` replacement |
| fzf | pacman | Fuzzy finder |
| imv | pacman | Image viewer |
| ripgrep | pacman | Fast `grep` replacement |
| starship | pacman | Shell prompt |
| fastfetch | pacman | System info display |
| zoxide | pacman | Smarter `cd` |

---

## Optional applications

Install any of these after setup with `bash install.sh --apps`:

| App | Package(s) | Source |
|---|---|---|
| Clipboard history | cliphist | pacman |
| Bluetooth | bluez, bluez-utils, blueman | pacman |
| File manager | dolphin | pacman |
| Visual Studio Code | visual-studio-code-bin | AUR |
| GitHub CLI | github-cli | pacman |
| Claude Code | @anthropic-ai/claude-code | npm |

---

## Helper scripts

| Script | Usage |
|---|---|
| `scripts/set-theme.sh <name>` | Apply an aether preset theme |
| `scripts/set-wallpaper.sh <image>` | Set wallpaper and derive aether colors |
| `scripts/screenshot.sh [region\|screen\|window]` | Take a screenshot |
