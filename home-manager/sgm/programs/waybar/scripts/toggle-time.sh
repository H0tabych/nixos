#!/usr/bin/env bash
# ~/.config/waybar/scripts/toggle-time.sh
CONFIG="$HOME/.config/waybar/config.jsonc"
TMP="$HOME/.config/waybar/config.tmp.jsonc"

CURRENT=$(grep -A1 "\"clock\":" "$CONFIG" | grep "format\":" | head -1 | sed -E 's/.*"format": "(.*)".*/\1/')

if [[ "$CURRENT" == "{:%H:%M}" ]]; then
  NEW_FORMAT="{:%a %d %b %H:%M}"
else
  NEW_FORMAT="{:%H:%M}"
fi

sed -E "/\"clock\":/,/}/{ s/\"format\": \"[^\"]*\"/\"format\": \"$NEW_FORMAT\"/ }" "$CONFIG" > "$TMP"
mv "$TMP" "$CONFIG"
pkill -RTMIN+8 waybar
