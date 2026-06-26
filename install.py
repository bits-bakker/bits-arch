#!/usr/bin/env python3
"""
bits-arch installer
Run after a fresh archinstall minimal-profile setup.
Usage:
  python install.py           # full interactive install
  python install.py --apps    # on-demand application installer
  python install.py --switch terminal  # swap terminal emulator
"""

import argparse
import os
import subprocess
import sys
from pathlib import Path

try:
    import inquirer
except ImportError:
    subprocess.run([sys.executable, "-m", "pip", "install", "--user", "inquirer"], check=True)
    import inquirer

REPO_DIR = Path(__file__).parent.resolve()
SCRIPTS = REPO_DIR / "scripts"


class C:
    RED    = "\033[0;31m"
    YELLOW = "\033[0;33m"
    GREEN  = "\033[0;32m"
    BLUE   = "\033[0;34m"
    CYAN   = "\033[0;36m"
    BOLD   = "\033[1m"
    DIM    = "\033[2m"
    NC     = "\033[0m"


def log_header(tag: str, msg: str) -> None:
    print(f"\n{C.BOLD}{C.BLUE}[{tag}]{C.NC} {msg}")

def log_step(msg: str) -> None:
    print(f"  {C.CYAN}→{C.NC} {msg}")

def log_done(msg: str) -> None:
    print(f"{C.GREEN}[done]{C.NC} {msg}")

def log_warn(msg: str) -> None:
    print(f"{C.YELLOW}[warn]{C.NC} {msg}")

def log_error(msg: str) -> None:
    print(f"{C.RED}[error]{C.NC} {msg}", file=sys.stderr)


APPS: dict[str, dict] = {
    "clipboard":    {"label": "Clipboard history (cliphist)",       "pkg": "cliphist"},
    "bluetooth":    {"label": "Bluetooth support (bluez + blueman)", "pkg": "bluez"},
    "file-manager": {"label": "File manager (Dolphin)",              "pkg": "dolphin"},
    "vscode":       {"label": "Visual Studio Code",                  "cmd": "code"},
    "gh":           {"label": "GitHub CLI",                          "pkg": "github-cli"},
    "claude-code":  {"label": "Claude Code — AI coding CLI",         "cmd": "claude"},
}


def is_installed(entry: dict) -> bool:
    if "pkg" in entry:
        return subprocess.run(["pacman", "-Qi", entry["pkg"]], capture_output=True).returncode == 0
    if "cmd" in entry:
        return subprocess.run(["which", entry["cmd"]], capture_output=True).returncode == 0
    return False


def run(script: Path, *args: str) -> None:
    result = subprocess.run(["bash", str(script), *args])
    if result.returncode != 0:
        log_error(f"Script failed: {script.name}")
        sys.exit(result.returncode)


def ask_confirm(msg: str) -> bool:
    answer = inquirer.prompt([inquirer.Confirm("ok", message=msg, default=True)])
    if answer is None:
        return False
    return bool(answer["ok"])


def install_core() -> None:
    log_header("core", "Installing base packages...")
    core = SCRIPTS / "core"
    ordered = [core / "yay.sh"] + sorted(
        s for s in core.glob("*.sh") if s.name != "yay.sh"
    )
    for script in ordered:
        log_step(script.stem)
        run(script)


def install_component(role: str, name: str) -> None:
    script = SCRIPTS / role / f"{name}.sh"
    if not script.exists():
        log_warn(f"No install script found for {role}/{name}, skipping.")
        return
    log_header(role, f"Installing {name}...")
    run(script)


def install_dotfiles() -> None:
    log_header("dotfiles", "Linking dotfiles with stow...")
    run(SCRIPTS / "dotfiles.sh")


def enable_services() -> None:
    log_header("services", "Enabling systemd user services...")
    run(SCRIPTS / "services.sh")


def post_install() -> None:
    log_header("post-install", "Finalising system setup...")
    run(SCRIPTS / "post-install.sh")


def apply_theme() -> None:
    log_header("theme", "Applying initial theme...")
    run(SCRIPTS / "theme.sh")


def apps_menu() -> None:
    EXIT = "__exit__"
    while True:
        choices = []
        for key, entry in APPS.items():
            badge = " (installed)" if is_installed(entry) else ""
            choices.append((f"{entry['label']}{badge}", key))
        choices.append(("Exit", EXIT))

        answer = inquirer.prompt([
            inquirer.List("app", message="Select an application to install", choices=choices)
        ])
        if answer is None or answer["app"] == EXIT:
            break

        key = answer["app"]
        script = SCRIPTS / "extras" / f"{key}.sh"
        if script.exists():
            log_header("apps", f"Installing {key}...")
            run(script)
            log_done(f"{key} installed.")
        else:
            log_warn(f"No script found for {key}.")


def full_install() -> None:
    print(f"\n  {C.BOLD}bits-arch installer{C.NC}\n")
    print("  Starting from a fresh archinstall minimal base.")
    print(f"  {C.DIM}Terminal: kitty  |  Launcher: walker  |  Theming: aether{C.NC}\n")

    if not ask_confirm("Proceed with installation?"):
        print("Aborted.")
        sys.exit(0)

    install_core()
    install_component("terminal", "kitty")
    install_component("launcher", "walker")
    install_component("theming", "aether")
    install_dotfiles()
    enable_services()
    post_install()
    apply_theme()

    print(f"\n  {C.GREEN}{C.BOLD}Installation complete.{C.NC}")
    print(f"  Start Hyprland:   {C.CYAN}uwsm start hyprland{C.NC}")
    print(f"  Set a theme:      {C.CYAN}~/bits-arch/scripts/set-theme.sh dracula{C.NC}")
    print(f"  Set wallpaper:    {C.CYAN}~/bits-arch/scripts/set-wallpaper.sh <image>{C.NC}")
    print(f"  Install apps:     {C.CYAN}python install.py --apps{C.NC}")
    print()


def main() -> None:
    if os.geteuid() == 0:
        log_error("Do not run as root. Run as your regular user.")
        sys.exit(1)

    parser = argparse.ArgumentParser(description="bits-arch installer")
    parser.add_argument(
        "--apps",
        action="store_true",
        help="Open the on-demand application installer menu",
    )
    args = parser.parse_args()

    if args.apps:
        apps_menu()
    else:
        full_install()


if __name__ == "__main__":
    main()
