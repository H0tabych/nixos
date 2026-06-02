#!/usr/bin/env bash
chosen=$(echo -e "Shutdown\nReboot\nHibernate" | rofi -dmenu -i -p "Power Menu")
case "$chosen" in
  Shutdown) systemctl poweroff ;;
  Reboot) systemctl reboot ;;
  Hibernate) systemctl hibernate ;;
esac
