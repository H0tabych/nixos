# ~/nixos-config/home-manager/sgm/programs/hyprpaper.nix
{ config, pkgs, ... }:
let
  # Укажите ОТНОСИТЕЛЬНЫЙ путь от этого .nix файла до вашей картинки.
  # Если структура: ~/nixos-config/pictures/workspace.jpg
  # А этот файл: ~/nixos-config/home-manager/sgm/programs/hyprpaper.nix
  # То путь будет ../../../pictures/workspace.jpg
  wallpaperPath = ../../../pictures/workspace.jpg; 
in
{
  home.packages = with pkgs; [ hyprpaper ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      # Nix сам скопирует файл в /nix/store и подставит сюда путь вида /nix/store/xxxx-wallpaper.jpg
      wallpaper = [ ",${wallpaperPath}" ];
    };
  };
}
