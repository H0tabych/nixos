# ~/nixos-config/home-manager/sgm/programs/hypr-utils.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    grim              # Создание скриншотов
    slurp             # Выбор области
    satty             # Аннотирование скриншотов
    cliphist          # Менеджер истории буфера обмена
    brightnessctl     # Управление яркостью
    wl-clipboard      # CLI для Wayland буфера (требуется cliphist)
  ];

  # Скрипт для скриншотов с аннотацией
  home.file.".local/bin/screenshot".source = pkgs.writeShellScript    "screenshot" ''
    #!/usr/bin/env bash
    set -euo pipefail
    FILE=~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png
    mkdir -p ~/Pictures/Screenshots

    # ВАЖНО: satty не принимает флаг -o. Используем --output-filename.
    # Пайпим grim напрямую в satty через stdin.
    grim -g "$(slurp -d -b '#00000080')" - | satty --filename - --output-filename "$FILE"

    # Копируем готовый файл в буфер обмена
    wl-copy < "$FILE"
    notify-send "Screenshot saved" "$FILE"
  '';
}
