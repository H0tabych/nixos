{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swappy
    cliphist
    brightnessctl
    libnotify # ИСПРАВЛЕНО: для работы notify-send
  ];

  home.file.".local/bin/screenshot".source = pkgs.writeShellScript "screenshot" ''
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Логируем ошибки для отладки
    exec >> "$HOME/.local/bin/screenshot.log" 2>&1
    echo "--- $(date) ---"
    
    # Гарантируем наличие переменной Wayland
    export WAYLAND_DISPLAY="''${WAYLAND_DISPLAY:-wayland-0}"

    DIR="$HOME/Pictures/Screenshots"
    mkdir -p "$DIR"
    FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

    # slurp может быть отменена пользователем (Esc), это нормально
    if grim -g "$(slurp -d -b '#00000080')" "$FILE"; then
        # Копируем как изображение
        if wl-copy --type image/png < "$FILE"; then
            notify-send "Screenshot saved" "$FILE" -i "$FILE"
        else
            notify-send "Saved (clipboard failed)" "$FILE" -i "$FILE"
        fi
    else
        echo "Grim failed or cancelled by user"
    fi
  '';
}
