{ config, pkgs, ... }:

{
  # Внешние зависимости (только базовые утилиты)
  home.packages = with pkgs; [
    git
    ripgrep
    fd
    gcc
    gnumake
    curl
    wget
    unzip
    gnutar        # для распаковки Mason пакетов
    tree-sitter
  ];

  # Портативная конфигурация в ~/.config/nvim
  xdg.configFile."nvim".source = ./nvim-config;

  # Только установка Neovim, без extraLuaConfig
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
