# ===== LOGIN SHELL PROFILE =====
# Загружается только для login shells

# Загружаем переменные окружения из systemd (для Wayland/Hyprland)
if command -v dbus-update-activation-environment &> /dev/null; then
  dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP
fi

# Добавляем пользовательские bin-директории в PATH
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"
