#!/usr/bin/env bash
# ~/.config/waybar/scripts/toggle-cpu-mem-format.sh
FLAG_FILE="$HOME/.cache/waybar-cpu-mem-abs"
if [ -f "$FLAG_FILE" ]; then
    rm "$FLAG_FILE"
else
    touch "$FLAG_FILE"
fi
pkill -RTMIN+8 waybar
