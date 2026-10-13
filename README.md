<p align="center">

<img alt="GitHub Repo stars" src="preview.png">

</p>

# hyprland-dots

My Hyprland setup, synced from the machine. This repo is the single source
of truth: everything under `~/.config` that belongs to the Hyprland desktop
is a symlink into it.

Tested against **Hyprland 0.56.2** (Lua-config era) on Arch, alongside
KDE Plasma — sessions are separate (SDDM: `Hyprland`, `Hyprland (uwsm)`,
`Plasma`), so nothing here touches Plasma state.

## Layout

| Path | What it is |
|---|---|
| `hypr/` | Hyprland + hyprlock. **`hyprland.lua` is the live config** — Hyprland ≥ 0.55 loads Lua from `~/.config/hypr/hyprland.lua`; the old `hyprland.conf` syntax is deprecated and no longer read. `hyprlock.conf` is the lockscreen: `hyprlock.png` background, `profile_devil.png` avatar, `Fonts/` (SF Pro Display), `scripts/songdetail.sh` (current song on the lockscreen), `scripts/kbd-backlight.sh` (Framework 13 keyboard backlight), `keybind` (rofi keybind dumper, parses `hyprland.lua`), `xdg-portal-hyprland` (portal fixup, run at startup). |
| `hyprpanel/` | Hyprpanel — the active panel (bar, OSD, menus, notifications). |
| `uwsm/` | Env vars for the `hyprland-uwsm.desktop` session. |
| `kitty/` | Kitty terminal. |
| `rofi/` | Rofi (Catppuccin Mocha). `.catppuccin-rofi/` is the theme generator. |
| `wlogout/` | Logout menu. |
| `ranger/`, `neofetch/` | File manager + neofetch (shared with other sessions). |
| `user.js` | Firefox profile prefs (active profile). |
| `custom.lua` | LazyVim plugin. |
| `wallhaven-q21vkl.jpg` | Wallpaper (also kept in `~/Documents`, where `hyprland.lua` reads it). |

## Install

```sh
git clone git@github.com:Yejashi/hyprland-dots.git
./hyprland-dots/install.sh
```

The installer symlinks each directory into `~/.config`, backing up any
existing directory as `<name>.bak-<timestamp>` before replacing it. Re-run
it any time after pulling updates. It also:

- checks for the binaries the configs call and warns about any that are
  missing (see Requirements below), and
- installs **SF Pro Display** (used by hyprlock) into
  `~/.local/share/fonts` if fontconfig cannot resolve it — per-user and
  additive, never touches system fonts.

## Requirements

Binaries (all in the official repos): `hyprland` (≥ 0.55, for the Lua
config), `hyprlock`, `hyprpanel`, `rofi`, `kitty`, `grim`, `slurp`,
`grimblast`, `hyprpicker`, `walker`, `elephant`, `wpctl`, `brightnessctl`,
`playerctl`, `swaybg`, `wlogout`, `nm-applet`, `blueman-applet`,
`dbus-update-activation-environment`.

Fonts: **SF Pro Display** (hyprlock) — installed per-user by `install.sh`;
**JetBrains Mono Nerd Font** (kitty, rofi) — expected system-wide.

## Notes

- **Config is Lua**: edit `~/.config/hypr/hyprland.lua`, then reload the
  session (or `hyprctl reload`).
- **Panel**: hyprpanel is started at session start; waybar is not running.
- **Weather key**: the OpenWeatherMap key was removed from the committed
  `hyprpanel/config.json` (repo is public). Weather is disabled; if you
  re-enable it, enter the key via hyprpanel's UI.
- **Screenshots**: `Print` (active window), `ALT+Print` (whole screen),
  `CTRL+Print` (region) — all via `grimblast` with notifications.
- **Session switching**: log in via SDDM into `Hyprland`, `Hyprland (uwsm)`
  or `Plasma` — the desktops don't share state.
