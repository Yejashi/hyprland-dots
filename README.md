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
| `hypr/` | Hyprland + hyprlock. **`hyprland.lua` is the live config** — Hyprland ≥ 0.55 loads Lua from `~/.config/hypr/hyprland.lua`; the old `hyprland.conf` syntax is deprecated and no longer read. `hyprlock.conf` is the lockscreen: `hyprlock.png` background, `profile_devil.png` avatar, `Fonts/` (SF Pro Display, JetBrains Mono Nerd), `Scripts/songdetail.sh` (current song on the lockscreen), `scripts/` (grimblast captures), `mocha.conf` (Catppuccin Mocha palette), `keybind` (rofi keybind dumper), `xdg-portal-hyprland` (portal fixup, run at startup). |
| `hyprpanel/` | Hyprpanel — the active panel (bar, OSD, menus, notifications). |
| `uwsm/` | Env vars for the `hyprland-uwsm.desktop` session. |
| `kitty/` | Kitty terminal + kitty-themes. |
| `rofi/` | Rofi (Catppuccin Mocha). `.catppuccin-rofi/` is the theme generator. |
| `waybar/` | Waybar config + scripts (superseded by hyprpanel, kept). |
| `wlogout/` | Logout menu. |
| `ranger/`, `neofetch/` | File manager + neofetch (shared with other sessions). |
| `chrome/`, `user.js` | Firefox theming (userChrome / userContent). |
| `custom.lua` | LazyVim plugin. |
| `wallhaven-q21vkl.jpg` | Wallpaper (also kept in `~/Documents`, where `hyprland.lua` reads it). |

## Install

```sh
git clone git@github.com:Yejashi/hyprland-dots.git
./hyprland-dots/install.sh
```

The installer symlinks each directory into `~/.config`, backing up any
existing directory as `<name>.bak-<timestamp>` before replacing it. Re-run
it any time after pulling updates.

## Notes

- **Config is Lua**: edit `~/.config/hypr/hyprland.lua`, then reload the
  session (or `hyprctl reload`).
- **Panel**: hyprpanel is started at session start; waybar is not running.
- **Session switching**: log in via SDDM into `Hyprland`, `Hyprland (uwsm)`
  or `Plasma` — the desktops don't share state.
