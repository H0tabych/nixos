#!/usr/bin/env bash
# ~/.config/waybar/scripts/weather.sh
LOCATION="Syktyvkar"
WEATHER_DATA=$(curl -s "wttr.in/${LOCATION}?format=%c+%t")
if [ -z "$WEATHER_DATA" ]; then
  echo '{"text": "N/A", "tooltip": "Погода недоступна"}'
else
  ICON=$(echo "$WEATHER_DATA" | awk '{print $1}')
  TEMP=$(echo "$WEATHER_DATA" | awk '{print $2}')
  echo "{\"text\": \"$ICON  $TEMP\", \"tooltip\": \"Погода в $LOCATION: $TEMP\"}"
fi
