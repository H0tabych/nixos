#!/usr/bin/env bash
# ~/.config/waybar/scripts/cpu-mem.sh
ABS_MODE=$([ -f "$HOME/.cache/waybar-cpu-mem-abs" ] && echo true || echo false)

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1)
MEM=$(free -m | awk '/Mem:/{ printf "%.0f", $3/$2 * 100 }')

if $ABS_MODE; then
    MEM_TOTAL=$(free -h --si | awk '/Mem:/{print $2}')
    MEM_USED=$(free -h --si | awk '/Mem:/{print $3}')
    MEM_TEXT="${MEM_USED}/${MEM_TOTAL}"
else
    MEM_TEXT="${MEM}%"
fi

# Цвет CPU
CPU_COLOR="#4ADE80"
if [ "$CPU" -ge 90 ]; then CPU_COLOR="#EF4444"; 
elif [ "$CPU" -ge 70 ]; then CPU_COLOR="#FBBF24"; fi

# Цвет памяти
MEM_COLOR="#4ADE80"
if [ "$MEM" -ge 90 ]; then MEM_COLOR="#EF4444";
elif [ "$MEM" -ge 70 ]; then MEM_COLOR="#FBBF24"; fi

echo "{\"text\": \"<span foreground='${CPU_COLOR}'> ${CPU}%</span>  <span foreground='${MEM_COLOR}'> ${MEM_TEXT}</span>\"}"
