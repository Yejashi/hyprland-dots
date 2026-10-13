#!/usr/bin/env bash
#
# hyprland-dots installer
#
# Makes this repo the single source of truth: each directory below is
# symlinked into ~/.config. Safe to re-run — directories that already
# point here are left alone; any existing real directory is backed up
# as <name>.bak-<timestamp> before being replaced.
#
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
TS="$(date +%Y%m%d-%H%M%S)"

# Directories in this repo that are symlinked into ~/.config
DIRS=(hypr hyprpanel uwsm kitty rofi waybar wlogout ranger neofetch)

mkdir -p "$CONFIG_DIR"

# --- Requirements check -------------------------------------------------------
required=(hyprland hyprlock hyprpanel rofi kitty grim slurp grimblast hyprpicker
          walker elephant wpctl brightnessctl playerctl swaybg wlogout
          nm-applet blueman-applet dbus-update-activation-environment)
missing=()
for b in "${required[@]}"; do
    command -v "$b" >/dev/null 2>&1 || missing+=("$b")
done
if [[ ${#missing[@]} -gt 0 ]]; then
    echo "warning: missing binaries (install them, e.g. via pacman):"
    printf '  - %s\n' "${missing[@]}"
fi

# --- Fonts ---------------------------------------------------------------------
# SF Pro Display is used by hyprlock; install it per-user if fontconfig
# cannot resolve it. Additive only — never replaces system fonts.
if ! fc-match "SF Pro Display" 2>/dev/null | grep -qi "SF Pro Display"; then
    mkdir -p "$HOME/.local/share/fonts"
    cp -n "$REPO/hypr/Fonts/SF Pro Display/"*.otf "$HOME/.local/share/fonts/"
    fc-cache "$HOME/.local/share/fonts" >/dev/null 2>&1 || true
    echo "ok      fonts (SF Pro Display installed per-user)"
else
    echo "ok      fonts (SF Pro Display already available)"
fi

for name in "${DIRS[@]}"; do
    src="$REPO/$name"
    dst="$CONFIG_DIR/$name"

    if [[ ! -d "$src" ]]; then
        echo "skip    $name (not in repo)"
        continue
    fi

    # Already a symlink pointing at this repo?
    if [[ -L "$dst" && "$(readlink -f "$dst")" == "$src" ]]; then
        echo "ok      $name"
        continue
    fi

    if [[ -L "$dst" ]]; then
        echo "repoint $name (was -> $(readlink "$dst"))"
        rm "$dst"
    elif [[ -d "$dst" ]]; then
        if diff -rq "$src" "$dst" >/dev/null 2>&1; then
            echo "backup  $name (contents identical)"
        else
            echo "backup  $name (contents differ)"
        fi
        mv "$dst" "$dst.bak-$TS"
    fi

    ln -s "$src" "$dst"
    echo "link    $name -> $src"
done

# Wallpaper: hypr/hyprland.lua reads it from ~/Documents
wallpaper="$HOME/Documents/wallhaven-q21vkl.jpg"
if [[ -f "$REPO/wallhaven-q21vkl.jpg" && ! -f "$wallpaper" ]]; then
    mkdir -p "$HOME/Documents"
    cp "$REPO/wallhaven-q21vkl.jpg" "$wallpaper"
    echo "copy    wallpaper -> $wallpaper"
fi

echo "done."
