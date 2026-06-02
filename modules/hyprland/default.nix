# ~/nixos-config/modules/hyprland/default.nix
{ config, pkgs, ... }:

{
  # --- Включение Hyprland ---
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kanshi
    wdisplays
    wlr-randr
  ];

  # --- Переменные окружения для Wayland ---
  environment.variables = {
    # Заставляем Qt-приложения использовать Wayland
    QT_QPA_PLATFORM = "wayland";
    # Подсказываем приложениям на базе Chromium/Electron использовать Wayland
    NIXOS_OZONE_WL = "1";
    # Дополнительные переменные для улучшения работы NVIDIA на Wayland
    LIBVA_DRIVER_NAME = "nvidia";
    # Устраняет проблемы с мерцанием курсора в некоторых играх/приложениях
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
