# ~/nixos-config/modules/graphical-apps/libreoffice.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libreoffice-qt         # Вариант с лучшей интеграцией в окружения на базе Qt
    hunspell               # Система проверки орфографии
    hunspellDicts.ru_RU    # Русский словарь
    hunspellDicts.en_US    # Английский словарь
  ];

  # Включаем поддержку глобальной тёмной темы для LibreOffice
  home-manager.sharedModules = [{
    dconf.settings = {
      "org/libreoffice/registry" = {
        "UserInterface/ColorScheme" = "LibreOffice Dark";
      };
    };
  }];
}
