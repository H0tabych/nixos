# ~/nixos-config/modules/hyprland/default.nix
# Модуль для Hyprland Wayland compositor
# Примечание: programs.hyprland.enable включает пакет
# Конфигурация в home-manager: home-manager/sgm/hyprland.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  # --- Включение Hyprland ---
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Display management
    kanshi
    wdisplays
    wlr-randr

    # Screenshots and recording
    grim
    slurp
    wf-recorder

    # Clipboard
    wl-clipboard

    # Notifications
    mako
    libnotify
  ];

  # --- Переменные окружения для Wayland ---
  environment.variables = {
    # Для Wayland-приложений
    QT_QPA_PLATFORM = lib.mkDefault "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = lib.mkDefault "wayland";
    CLUTTER_BACKEND = "wayland";

    # Для Electron-приложений
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
