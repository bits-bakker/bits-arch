#!/usr/bin/env python3
"""
bits-arch installer
Run after a fresh archinstall minimal-profile setup.
Usage:
  python install.py              # full interactive install
  python install.py --switch terminal   # swap terminal emulator
  python install.py --switch launcher  # swap launcher
  python install.py --switch theming   # swap theming tool
"""

import argparse
import os
import subprocess
import sys
from pathlib import Path

try:
    import questionary
    from questionary import Style
except ImportError:
    subprocess.run([sys.executable, "-m", "pip", "install", "--user", "questionary"], check=True)
    import questionary
    from questionary import Style

REPO_DIR = Path(__file__).parent.resolve()
SCRIPTS = REPO_DIR / "scripts"

STYLE = Style([
    ("qmark", "fg:#89b4fa bold"),
    ("question", "bold"),
    ("answer", "fg:#a6e3a1 bold"),
    ("pointer", "fg:#89b4fa bold"),
    ("highlighted", "fg:#89b4fa"),
    ("selected", "fg:#a6e3a1"),
    ("separator", "fg:#6c7086"),
    ("instruction", "fg:#6c7086"),
])

TERMINALS = {
    "kitty": "Kitty — GPU-accelerated, rich theming support",
    "foot": "Foot — minimal, fast, pure Wayland",
    "ghostty": "Ghostty — modern, fast (AUR)",
}

LAUNCHERS = {
    "rofi": "Rofi — feature-rich, excellent theming (rofi-wayland)",
    "walker": "Walker — newer Wayland-native launcher (AUR)",
}

THEMING_TOOLS = {
    "matugen": "Matugen — colors derived from your wallpaper (Material You)",
    "aether":  "Aether — pick from preset themes (Dracula, Nord, Gruvbox, …)",
}

EXTRAS = {
    "clipboard":    "Clipboard history (cliphist — wl-clipboard is already installed)",
    "bluetooth":    "Bluetooth support (bluez + blueman)",
    "file-manager": "File manager (Thunar)",
    "vscode":       "Visual Studio Code (AUR: visual-studio-code-bin)",
    "gh":           "GitHub CLI (gh)",
    "claude-code":  "Claude Code — Anthropic's AI coding CLI",
}


def run(script: Path, *args: str) -> None:
    cmd = ["bash", str(script), *args]
    result = subprocess.run(cmd)
    if result.returncode != 0:
        print(f"\n[error] Script failed: {script.name}")
        sys.exit(result.returncode)


def ask_component(role: str, choices: dict[str, str]) -> str:
    options = [questionary.Choice(title=f"{k}  —  {v}", value=k) for k, v in choices.items()]
    answer = questionary.select(
        f"Which {role}?",
        choices=options,
        style=STYLE,
    ).ask()
    if answer is None:
        sys.exit(0)
    return answer


def ask_extras() -> list[str]:
    options = [questionary.Choice(title=f"{v}", value=k) for k, v in EXTRAS.items()]
    answer = questionary.checkbox(
        "Select optional extras (space to toggle, enter to confirm):",
        choices=options,
        style=STYLE,
    ).ask()
    if answer is None:
        sys.exit(0)
    return answer


def install_core() -> None:
    print("\n[core] Installing base packages...")
    core = SCRIPTS / "core"
    # matugen.sh also installs yay — run it first so AUR scripts can follow
    ordered = [core / "matugen.sh"] + sorted(
        s for s in core.glob("*.sh") if s.name != "matugen.sh"
    )
    for script in ordered:
        print(f"  → {script.stem}")
        run(script)


def install_component(role: str, name: str) -> None:
    script = SCRIPTS / role / f"{name}.sh"
    if not script.exists():
        print(f"[warn] No install script found for {role}/{name}, skipping.")
        return
    print(f"\n[{role}] Installing {name}...")
    run(script)


def install_extras(selected: list[str]) -> None:
    for name in selected:
        script = SCRIPTS / "extras" / f"{name}.sh"
        if script.exists():
            print(f"\n[extras] Installing {name}...")
            run(script)


def install_dotfiles(terminal: str, launcher: str, theming: str) -> None:
    print("\n[dotfiles] Linking dotfiles with stow...")
    run(SCRIPTS / "dotfiles.sh", terminal, launcher, theming)


def enable_services() -> None:
    print("\n[services] Enabling systemd user services...")
    run(SCRIPTS / "services.sh")


def post_install() -> None:
    print("\n[post-install] Finalising system setup...")
    run(SCRIPTS / "post-install.sh")


def apply_theme(theming: str) -> None:
    print("\n[theme] Applying initial theme...")
    run(SCRIPTS / "theme.sh", theming)


def switch_component(role: str) -> None:
    """Re-run just the component selection and swap dotfiles/tool."""
    if role == "terminal":
        choices = TERMINALS
    elif role == "launcher":
        choices = LAUNCHERS
    else:
        choices = THEMING_TOOLS

    name = ask_component(role, choices)

    if role == "theming":
        # Unlink matugen dotfiles if switching away from it
        run(SCRIPTS / "dotfiles.sh", "--unlink-theming")
        install_component("theming", name)
        run(SCRIPTS / "dotfiles.sh", f"--link-theming", name)
        print(f"\n[done] Switched theming to {name}.")
        if name == "aether":
            print("       Run: ~/bits-arch/scripts/set-theme.sh dracula")
        else:
            print("       Run: ~/bits-arch/scripts/set-wallpaper.sh <image>")
        return

    run(SCRIPTS / "dotfiles.sh", f"--unlink-{role}")
    install_component(role, name)
    run(SCRIPTS / "dotfiles.sh", f"--link-{role}", name)

    print(f"\n[done] Switched {role} to {name}.")
    print(f"       Log out and back in (or restart Hyprland) to apply.")


def full_install() -> None:
    print("\n  bits-arch installer\n")
    print("  Starting from a fresh archinstall minimal base.")
    print("  Answer the prompts below to customise your setup.\n")

    terminal = ask_component("terminal", TERMINALS)
    launcher = ask_component("launcher", LAUNCHERS)
    theming  = ask_component("theming",  THEMING_TOOLS)
    extras   = ask_extras()

    print(f"\n  Selected: {terminal} · {launcher} · {theming}")
    if extras:
        print(f"  Extras:   {', '.join(extras)}")
    print()

    confirmed = questionary.confirm("Proceed with installation?", style=STYLE, default=True).ask()
    if not confirmed:
        print("Aborted.")
        sys.exit(0)

    install_core()
    install_component("terminal", terminal)
    install_component("launcher", launcher)
    install_component("theming",  theming)
    install_extras(extras)
    install_dotfiles(terminal, launcher, theming)
    enable_services()
    post_install()
    apply_theme(theming)

    print("\n  Installation complete.")
    print("  Start Hyprland by running: Hyprland")
    if theming == "matugen":
        print("  Change wallpaper + theme:  ~/bits-arch/scripts/set-wallpaper.sh <image>")
    else:
        print("  Change preset theme:       ~/bits-arch/scripts/set-theme.sh <name>")
        print("  Change wallpaper only:     ~/bits-arch/scripts/set-wallpaper.sh <image>")
    print()


def main() -> None:
    if os.geteuid() == 0:
        print("[error] Do not run as root. Run as your regular user.")
        sys.exit(1)

    parser = argparse.ArgumentParser(description="bits-arch installer")
    parser.add_argument(
        "--switch",
        metavar="ROLE",
        choices=["terminal", "launcher", "theming"],
        help="Switch a component without full reinstall",
    )
    args = parser.parse_args()

    if args.switch:
        switch_component(args.switch)
    else:
        full_install()


if __name__ == "__main__":
    main()
