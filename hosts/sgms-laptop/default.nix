# ~/nixos-config/hosts/sgms-laptop/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Импортируем модули для этого хоста
  imports = [
    # Автоматически сгенерированный файл с оборудованием (мы его создадим позже)
    ./hardware.nix
    # Основные системные настройки
    ./system.nix
    # Настройка impermanence
    ./impermanence.nix
    # Список системных пакетов
    ./packages.nix
    ./nvidia.nix

    # Модуль для настройки гибридной графики NVIDIA (создадим позже)
    ../../modules/nvidia
    ../../modules/hyprland
    ../../modules/zsh
    ../../modules/automount
    ../../modules/vpn
    ../../modules/docker
    ../../modules/direnv
    ../../modules/sddm
    ../../modules/gaming

    # Audio modules
    ../../modules/audio/pipewire.nix
    ../../modules/audio/bluetooth.nix
    ../../modules/audio/xdg-portal.nix

    ../../modules/graphical-apps/firefox.nix
    ../../modules/graphical-apps/libreoffice.nix
    ../../modules/graphical-apps/zed.nix
    ../../modules/graphical-apps/telegram.nix
    ../../modules/graphical-apps/dbeaver.nix
    ../../modules/graphical-apps/transmission.nix
    ../../modules/graphical-apps/postman.nix
    ../../modules/terminal-apps/docker-compose.nix
    ../../modules/terminal-apps/lazydocker.nix
    ../../modules/terminal-apps/lazygit.nix
  ];
}
