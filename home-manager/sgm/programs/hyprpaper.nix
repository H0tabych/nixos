# ~/nixos-config/home-manager/sgm/programs/hyprpaper.nix
{ config, pkgs, ... }:
{
  # Копируем обои из репозитория в домашнюю директорию
  home.file.".config/hypr/wallpaper.jpg".source = /home/sgm/nixos-config/pictures/workspace.jpg;

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      # Новый синтаксис: массив attrset'ов
      wallpaper = [
        {
          monitor = ""; # Пустая строка означает "все мониторы"
          path = "${config.home.homeDirectory}/.config/hypr/wallpaper.jpg";
        }
      ];
    };
  };
}
