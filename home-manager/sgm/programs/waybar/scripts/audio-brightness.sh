#!/usr/bin/env bash
VOL=$(pamixer --get-volume)
MUTE=$(pamixer --get-mute)
BRIGHT=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

if [ "$MUTE" = "true" ]; then
    VOL_ICON=""
else
    if [ "$VOL" -ge 50 ]; then VOL_ICON=""; 
    elif [ "$VOL" -ge 1 ]; then VOL_ICON="";
    else VOL_ICON=""; fi
fi

# Цвета: громкость – синий, яркость – жёлтый
echo "{\"text\": \"<span foreground='#60a5fa'>${VOL_ICON} ${VOL}%</span>  <span foreground='#fbbf24'> ${BRIGHT}%</span>\"}"
