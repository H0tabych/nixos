{ config, pkgs, ... }:

{
  # 1. Устанавливаем внешние зависимости для плагинов и LSP
  home.packages = with pkgs; [
    # Зависимости для работы плагинов (Telescope, LSP, компиляция)
    git
    ripgrep       # для поиска (Telescope/fzf)
    fd            # для поиска файлов
    tree-sitter   # для парсинга синтаксиса
    gcc           # для компиляции некоторых плагинов
    gnumake
    curl
    wget
    unzip
    
    # LSP серверы (опционально, но рекомендуется)
    pyright       # Python
    clang-tools   # C++ (clangd)
    nil           # Nix
    lua-language-server  # Lua
  ];

  # 2. Связываем нашу портативную папку с ~/.config/nvim
  # Это работает и на NixOS, и (через скрипт) на других системах
  xdg.configFile."nvim".source = ./nvim-config;

  # 3. Базовая настройка Neovim через Home Manager
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
