{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swappy     # Стабильный редактор скриншотов для Wayland
    cliphist
    brightnessctl
  ];

  home.file.".local/bin/screenshot".source = pkgs.writeShellScript "screenshot" ''
    #!/usr/bin/env bash
    set -euo pipefail
    
    DIR="$HOME/Pictures/Screenshots"
    mkdir -p "$DIR"
    FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

    # Делаем скриншот области
    if grim -g "$(slurp -d -b '#00000080')" "$FILE"; then
        # КРИТИЧНО: Копируем в буфер обмена как ИЗОБРАЖЕНИЕ
        wl-copy --type image/png < "$FILE"
        
        notify-send "Screenshot saved" "$FILE" -i "$FILE"
        
        # Если нужно редактирование, раскомментируйте:
        # swappy -f "$FILE"
    fi
  '';
}
