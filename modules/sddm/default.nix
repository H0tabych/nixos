# ~/nixos-config/modules/sddm/default.nix
{
  config,
  pkgs,
  lib,
  user,
  ...
}: let
  # Настройки темы в стиле Glassmorphism
  themeConfig = {
    ScreenWidth = "1920";
    ScreenHeight = "1080";
    Font = "JetBrains Mono";
    FontSize = "12";
    RoundCorners = "20"; # Скругления в стиле вашей панели
    BackgroundPlaceholder = ""; # Путь к картинке-заглушке, если нужна
    Background = "/home/${user}/Pictures/workspaces/workspace.jpg"; # Основной фон (замените на ваш файл)
    DimBackground = "0.0"; # Затемнение фона
    HeaderTextColor = "#e0e0e0"; # Цвет заголовка (мягкий белый)
    DateTextColor = "#e0e0e0";
    TimeTextColor = "#e0e0e0";
    FormBackgroundColor = "rgba(18, 18, 18, 0.85)"; # Стеклянный фон формы
    BackgroundColor = "rgba(18, 18, 18, 0.85)";
    DimBackgroundColor = "rgba(18, 18, 18, 0.85)";
    LoginFieldBackgroundColor = "rgba(18, 18, 18, 0.7)";
    PasswordFieldBackgroundColor = "rgba(18, 18, 18, 0.7)";
    LoginFieldTextColor = "#e0e0e0";
    PasswordFieldTextColor = "#e0e0e0";
    UserIconColor = "#4ade80"; # Зелёный акцент для иконок
    PasswordIconColor = "#4ade80";
    PlaceholderTextColor = "#a0a0a0";
    WarningColor = "#ef4444"; # Красный для ошибок
    LoginButtonTextColor = "#121212";
    LoginButtonBackgroundColor = "#4ade80"; # Зелёная кнопка входа
    SystemButtonsIconsColor = "#60a5fa"; # Синий для системных кнопок
    SessionButtonTextColor = "#60a5fa";
    VirtualKeyboardButtonTextColor = "#60a5fa";
    DropdownTextColor = "#e0e0e0";
    DropdownSelectedBackgroundColor = "rgba(74, 222, 128, 0.2)";
    DropdownBackgroundColor = "rgba(18, 18, 18, 0.7)";
    HighlightTextColor = "#121212";
    HighlightBackgroundColor = "#4ade80";
    HighlightBorderColor = "#4ade80";
  };

  sddm-astronaut = pkgs.sddm-astronaut.override {
    inherit themeConfig;
    embeddedTheme = "astronaut"; # Используем базовый вариант темы
  };
in {
  # === SDDM ===
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Включаем нативный Wayland-бэкенд
    theme = "sddm-astronaut-theme"; # Название темы
    extraPackages = [
      sddm-astronaut
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtvirtualkeyboard
      pkgs.kdePackages.qtmultimedia
    ];
    settings = {
      Theme = {
        CursorTheme = "Adwaita";
        CursorSize = 24;
      };
    };
  };

  # === ПАКЕТ ТЕМЫ В ОКРУЖЕНИИ ===
  environment.systemPackages = [sddm-astronaut];
}
