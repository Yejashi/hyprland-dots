#!/usr/bin/env bash
# Keyboard backlight — Framework 13 (chromeos::kbd_backlight LED device).
set -euo pipefail

LED=/sys/class/leds/chromeos::kbd_backlight
[ -d "$LED" ] || { echo "kbd-backlight: $LED not found" >&2; exit 1; }

cur=$(cat "$LED/brightness")
max=$(cat "$LED/max_brightness")
step=$(( max / 10 + 1 ))

case "${1:-}" in
    up)   next=$(( cur + step > max ? max : cur + step )) ;;
    down) next=$(( cur - step < 0 ? 0 : cur - step )) ;;
    *)    echo "usage: kbd-backlight.sh up|down" >&2; exit 1 ;;
esac

echo "$next" > "$LED/brightness"
