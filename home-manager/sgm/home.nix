# ~/nixos-config/home-manager/sgm/home.nix
{
  config,
  pkgs,
  user,
  nixosVersion,
  ...
}: {
  # Базовая информация о пользователе
  home.username = user;
  home.homeDirectory = "/home/${user}";

  # Указываем, что Home Manager должен управлять вашим окружением
  programs.home-manager.enable = true;

  # --- ПАКЕТЫ, УСТАНАВЛИВАЕМЫЕ ТОЛЬКО ДЛЯ ПОЛЬЗОВАТЕЛЯ sgm ---
  home.packages = with pkgs; [
    # Здесь можно перечислить программы, которые нужны только этому пользователю
    # Например, специфичные инструменты разработки или медиаплееры
    nerd-fonts.jetbrains-mono
  ];

  # --- НАСТРОЙКИ ОТДЕЛЬНЫХ ПРОГРАММ ---
  # Здесь мы будем импортировать конфигурации для конкретных программ.
  # Например, для Neovim, Git, Zsh и т.д.
  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/foot.nix
    ./programs/theming.nix
    ./programs/yazi.nix
    ./hyprland.nix
    ./programs/hypr-security.nix
    ./programs/waybar
    ./programs/hypr-ui
    ./programs/hypr-utils.nix
    ./programs/networkmanager-dmenu.nix
    ./programs/hyprpaper.nix
    ./programs/media.nix
    ./programs/neovim/default.nix
    ./programs/mako.nix

    ./programs/mangohud.nix

    ./programs/zed.nix
  ];

  # === СТАНДАРТНЫЕ ДИРЕКТОРИИ ПОЛЬЗОВАТЕЛЯ (XDG) ===
  # Включаем автоматическое создание и управление директориями
  xdg.userDirs = {
    enable = true;
    createDirectories = true; # Создаём папки, если их нет
    # Настраиваем пути
    desktop = "\${HOME}/Desktop";
    documents = "\${HOME}/Documents";
    download = "\${HOME}/Downloads";
    music = "\${HOME}/Music";
    pictures = "\${HOME}/Pictures";
    publicShare = "\${HOME}/Public";
    templates = "\${HOME}/Templates";
    videos = "\${HOME}/Videos";
  };

  # Состояние home-manager должно соответствовать версии NixOS
  home.stateVersion = nixosVersion;
}
