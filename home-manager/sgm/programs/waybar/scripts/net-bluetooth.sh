#!/usr/bin/env bash
# ~/.config/waybar/scripts/net-bluetooth.sh

CACHE_DIR="$HOME/.cache/waybar"
mkdir -p "$CACHE_DIR"
RX_FILE="$CACHE_DIR/net_rx"
TX_FILE="$CACHE_DIR/net_tx"

WIFI_IFACE=$(nmcli -t -f DEVICE,TYPE,STATE dev 2>/dev/null | grep ':wifi:connected' | head -1 | cut -d: -f1)
ETH_IFACE=$(nmcli -t -f DEVICE,TYPE,STATE dev 2>/dev/null | grep ':ethernet:connected' | head -1 | cut -d: -f1)
WIFI_DATA=$(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi 2>/dev/null | grep '^yes' | head -1)

if [ -n "$WIFI_IFACE" ] && [ -n "$WIFI_DATA" ]; then
    IFACE="$WIFI_IFACE"
    SSID=$(echo "$WIFI_DATA" | cut -d: -f2)
    SIGNAL=$(echo "$WIFI_DATA" | cut -d: -f3)
    if [ "$SIGNAL" -ge 75 ]; then
        WIFI_ICON=""
        WIFI_COLOR="#4ade80"
    elif [ "$SIGNAL" -ge 50 ]; then
        WIFI_ICON=""
        WIFI_COLOR="#60a5fa"
    elif [ "$SIGNAL" -ge 25 ]; then
        WIFI_ICON=""
        WIFI_COLOR="#fbbf24"
    else
        WIFI_ICON=""
        WIFI_COLOR="#ef4444"
    fi
elif [ -n "$ETH_IFACE" ]; then
    IFACE="$ETH_IFACE"
    WIFI_ICON=""
    WIFI_COLOR="#60a5fa"
    SSID=""
else
    echo '{"text": "", "tooltip": "No connection"}'
    exit 0
fi

# Трафик
RX_NOW=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
TX_NOW=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
if [ -f "$RX_FILE" ] && [ -f "$TX_FILE" ]; then
    RX_PREV=$(cat "$RX_FILE")
    TX_PREV=$(cat "$TX_FILE")
    INTERVAL=3
    RX_RATE=$(( (RX_NOW - RX_PREV) / INTERVAL ))
    TX_RATE=$(( (TX_NOW - TX_PREV) / INTERVAL ))

    format_speed() {
        local bytes=$1
        if [ $bytes -ge 1048576 ]; then
            printf "%.1f MB/s" $(echo "$bytes / 1048576" | bc -l)
        elif [ $bytes -ge 1024 ]; then
            printf "%.1f KB/s" $(echo "$bytes / 1024" | bc -l)
        else
            echo "$bytes B/s"
        fi
    }
    RX_FMT=$(format_speed $RX_RATE)
    TX_FMT=$(format_speed $TX_RATE)
else
    RX_FMT="--"
    TX_FMT="--"
fi
echo "$RX_NOW" > "$RX_FILE"
echo "$TX_NOW" > "$TX_FILE"

# Bluetooth
BT_POWERED=$(bluetoothctl show 2>/dev/null | grep "Powered: yes" || true)
BT_TEXT=""
if [ -n "$BT_POWERED" ]; then
    CONNECTED=$(bluetoothctl devices Connected 2>/dev/null | wc -l)
    if [ "$CONNECTED" -gt 0 ]; then
        BT_TEXT="  ${CONNECTED}"
    else
        BT_TEXT=" "
    fi
fi

echo "{\"text\": \"<span foreground='#4ade80'> ${RX_FMT}</span> <span foreground='#ef4444'> ${TX_FMT}</span> <span foreground='${WIFI_COLOR}'>${WIFI_ICON}</span>${BT_TEXT}\"}"
