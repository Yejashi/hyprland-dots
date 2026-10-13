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
