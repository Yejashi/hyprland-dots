-- Hyprland configuration (Lua format, Hyprland 0.55+)
-- Converted from the previous hyprland.conf. Old file kept as hyprland.conf.bak

-- █▀▀ ▀▄▀ █▀▀ █▀▀
-- ██▄ █░█ ██▄ █▄▄

local home = os.getenv("HOME")

hl.on("hyprland.start", function()
    -- wl-clipboard-history is not installed; elephant-clipboard handles clipboard history
    -- hl.exec_cmd("wl-clipboard-history -t")
    hl.exec_cmd("systemctl --user start elephant.service")
    hl.exec_cmd("walker --gapplication-service")
    hl.exec_cmd(home .. "/.config/hypr/xdg-portal-hyprland")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("swaybg -m stretch -i " .. home .. "/Documents/wallhaven-q21vkl.jpg")
    -- hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpanel")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
end)

-- █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
-- █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.3333334,
})

-- █ █▄░█ █▀█ █░█ ▀█▀
-- █ █░▀█ █▀▀ █▄█ ░█░
hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.
        repeat_delay = 300,
        repeat_rate  = 50,
    },
})

-- █▀▀ █▀▀ █▄░█ █▀▀ █▀█ ▄▀█ █░░
-- █▄█ ██▄ █░▀█ ██▄ █▀▄ █▀█ █▄▄
hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 5,
        border_size = 0,
        layout      = "dwindle",
    },
})

-- █▀▄▀█ █ █▀ █▀▀
-- █░▀░█ █ ▄█ █▄▄
hl.config({
    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms  = true,
        enable_swallow           = true,
        swallow_regex            = "^(kitty)$",
    },
})

-- █▀▄ █▀▀ █▀▀ █▀█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
-- █▄▀ ██▄ █▄▄ █▄█ █▀▄ █▀█ ░█░ █ █▄█ █░▀█
hl.config({
    decoration = {
        -- █▀█ █▀█ █░█ █▄░█ █▀▄   █▀▀ █▀█ █▀█ █▄░█ █▀▀ █▀█
        -- █▀▄ █▄█ █▄█ █░▀█ █▄▀   █▄▄ █▄█ █▀▄ █░▀█ ██▄ █▀▄
        rounding = 8,

        -- █▀█ █▀█ ▄▀█ █▀▀ █ ▀█▀ █▄█
        -- █▄█ █▀▀ █▀█ █▄▄ █ ░█░ ░█░
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        -- █▄▄ █░░ █░█ █▀█
        -- █▄█ █▄▄ █▄█ █▀▄
        blur = {
            enabled           = true,
            size              = 3,
            passes            = 3,
            new_optimizations = true,
            ignore_opacity    = true,
        },

        -- █▀ █░█ ▄▀█ █▀▄ █▀█ █░█░█
        -- ▄█ █▀█ █▀█ █▄▀ █▄█ ▀▄▀▄▀
        -- shadow = {
        --     enabled      = true,
        --     ignore_window = true,
        --     offset       = "2 2",
        --     range        = 4,
        --     render_power = 2,
        --     color        = 0x66000000,
        -- },
    },
})

hl.layer_rule({ match = { namespace = "gtk-layer-shell" }, blur = true })
-- hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "lockscreen" }, blur = true })

-- ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
-- █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█
hl.config({
    animations = {
        enabled = true,
    },
})

-- █▄▄ █▀▀ ▀█ █ █▀▀ █▀█   █▀▀ █░█ █▀█ █░█ █▀▀
-- █▄█ ██▄ █▄ █ ██▄ █▀▄   █▄▄ █▄█ █▀▄ ▀▄▀ ██▄
hl.curve("overshot",  { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05}  } })
hl.curve("smoothOut", { type = "bezier", points = { {0.36, 0},   {0.66, -0.56} } })
hl.curve("smoothIn",  { type = "bezier", points = { {0.25, 1},   {0.5, 1}      } })

hl.animation({ leaf = "windows",     enabled = true, speed = 1,  bezier = "overshot",  style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 1,  bezier = "smoothOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1,  bezier = "default" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10, bezier = "smoothIn" })
hl.animation({ leaf = "fadeDim",     enabled = true, speed = 10, bezier = "smoothIn" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 2,  bezier = "default" })

-- █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀ █▀
-- █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░ ▄█
hl.config({
    dwindle = {
        preserve_split = true, -- you probably want this
    },
})

-- █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
-- ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█
hl.window_rule({ match = { title = "Open File" },    float = true })
hl.window_rule({ match = { title = "branchdialog" }, float = true })
hl.window_rule({ match = { title = "wlogout" },      float = true, fullscreen = true })
hl.window_rule({ match = { title = "^(Media viewer)$" },      float = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({
    match = { title = "^(Volume Control)$" },
    float = true,
    size  = { 800, 600 },
    move  = { 75, "monitor_h*0.44" },
})

-- █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄
-- █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀
-- hl.bind("SUPER + L", hl.dsp.exec_cmd("wlogout"))
-- hl.bind("SUPER + F1", hl.dsp.exec_cmd(home .. "/.config/hypr/keybind"))
hl.bind("SUPER + F2", hl.dsp.exec_cmd("zen-browser"))
hl.bind("SUPER + F1", hl.dsp.exec_cmd("firefox --private-window"))

-- Brightness control
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +5%"))

-- Keyboard backlight. These were `code:238` / `code:237` in the old config;
-- Hyprland 0.56.2 does not parse the `code:` prefix in Lua binds (the bind
-- registers with an empty key and never fires), so they use the equivalent
-- keysyms instead: xkb keycode 238 = XF86KbdBrightnessUp, 237 = XF86KbdBrightnessDown.
hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd("asusctl -n"))
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("asusctl -p"))

-- █▀▄▀█ █░█ █░░ ▀█▀ █ █▀▄▀█ █▀▀ █▀▄ █ ▄▀█
-- █░▀░█ █▄█ █▄▄ ░█░ █ █░▀░█ ██▄ █▄▀ █ █▀█
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"))

-- █▀ █▀▀ █▀█ █▀▀ █▀▀ █▄░█ █▀ █░█ █▀█ ▀█▀
-- ▄█ █▄▄ █▀▄ ██▄ ██▄ █░▀█ ▄█ █▀█ █▄█ ░█░
-- local screenshotarea = 'hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"'
-- hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(screenshotarea))
hl.bind("Print",       hl.dsp.exec_cmd("grimblast --notify --cursor copysave output"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("grimblast --notify --cursor copysave screen"))

-- █▀▄▀█ █ █▀ █▀▀
-- █░▀░█ █ ▄█ █▄▄
hl.bind("SUPER + SHIFT + X", hl.dsp.exec_cmd("hyprpicker -a -n"))
hl.bind("CTRL + ALT + L",    hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + Return",         hl.dsp.exec_cmd("kitty --single-instance"))
hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd("wezterm"))
hl.bind("SUPER + X",  hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + F3", hl.dsp.exec_cmd("thunar"))
-- hl.bind("CTRL + SHIFT + P", hl.dsp.exec_cmd("walker"))
hl.bind("CTRL + P", hl.dsp.exec_cmd("walker"))
hl.bind("SUPER + period", hl.dsp.exec_cmd('killall rofi || rofi -show emoji -emoji-format "{emoji}" -modi emoji'))
hl.bind("SUPER + escape", hl.dsp.exec_cmd("wlogout --protocol layer-shell -b 5 -T 400 -B 400"))

-- █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
-- ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █░▀░█ █▀█ █░▀█ █▀█ █▄█ █░▀░█ ██▄ █░▀█ ░█░
hl.bind("SUPER + SHIFT + Q",     hl.dsp.window.close())
hl.bind("SUPER + SHIFT + F10",   hl.dsp.exit())
hl.bind("SUPER + F",             hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("SUPER + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind("SUPER + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind("SUPER + S", hl.dsp.layout("togglesplit")) -- dwindle

-- Screenshot
hl.bind("SUPER + CTRL + Return", hl.dsp.exec_cmd("grim $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')"))
hl.bind("CTRL + Print",          hl.dsp.exec_cmd("grim -g \"$(slurp -o)\" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')"))
hl.bind("CTRL + SHIFT + Print",  hl.dsp.exec_cmd("grim -g \"$(slurp)\" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')"))

-- █▀▀ █▀█ █▀▀ █░█ █▀
-- █▀░ █▄█ █▄▄ █▄█ ▄█
hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))

-- █▀▄▀█ █▀█ █░█ █▀▀
-- █░▀░█ █▄█ ▀▄▀ ██▄
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))

-- █▀█ █▀▀ █▀ █ ▀█ █▀▀
-- █▀▄ ██▄ ▄█ █ █▄ ██▄
hl.bind("SUPER + CTRL + H", hl.dsp.window.resize({ x = -20, y = 0,   relative = true }))
hl.bind("SUPER + CTRL + L", hl.dsp.window.resize({ x = 20,  y = 0,   relative = true }))
hl.bind("SUPER + CTRL + K", hl.dsp.window.resize({ x = 0,   y = -20, relative = true }))
hl.bind("SUPER + CTRL + J", hl.dsp.window.resize({ x = 0,   y = 20,  relative = true }))

-- ▀█▀ ▄▀█ █▄▄ █▄▄ █▀▀ █▀▄
-- ░█░ █▀█ █▄█ █▄█ ██▄ █▄▀
hl.bind("SUPER + g", hl.dsp.group.toggle())
hl.bind("SUPER + Q", hl.dsp.group.next())
hl.bind("SUPER + SHIFT + S", hl.dsp.layout("togglesplit"))

-- █▀ █▀█ █▀▀ █▀▀ █ ▄▀█ █░░
-- ▄█ █▀▀ ██▄ █▄▄ █ █▀█ █▄▄
hl.bind("SUPER + equal", hl.dsp.workspace.toggle_special())
hl.bind("SUPER + minus", hl.dsp.window.move({ workspace = "special" }))
hl.bind("SUPER + SHIFT + equal", hl.dsp.group.lock({ action = "toggle" }))

-- █▀ █░█░█ █ ▀█▀ █▀▀ █░█
-- ▄█ ▀▄▀▄▀ █ ░█░ █▄▄ █▀█
-- █▀▄▀█ █▀█ █░█ █▀▀
-- █░▀░█ █▄█ ▀▄▀ ██▄
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind("SUPER + grave", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + Tab",   hl.dsp.focus({ workspace = "e-1" }))

-- █▀▄▀█ █▀█ █░█ █▀ █▀▀   █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀
-- █░▀░█ █▄█ █▄█ ▄█ ██▄   █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.config({
    xwayland = {
        enabled            = true,
        force_zero_scaling = true,
    },
})
