{
  config,
  pkgs,
  ...
}: {
  # 1. Устанавливаем Neovim и внешние зависимости, необходимые для плагинов и LSP
  home.packages = with pkgs; [
    # Зависимости для работы плагинов (Telescope, LSP, компиляция)
    git
    ripgrep # для поиска (Telescope/fzf)
    fd # для поиска файлов
    tree-sitter # для парсинга синтаксиса
    gcc # для компиляции некоторых плагинов
    gnumake
    curl
    wget
    unzip
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

    # Мы НЕ используем nixvim здесь, чтобы конфигурация оставалась портативной.
    # Все плагины будут управляться через lazy.nvim внутри nvim-config.
    extraLuaConfig = ''
      -- Минимальные настройки, чтобы Neovim вел себя хорошо до загрузки lazy.nvim
      vim.g.mapleader = " "
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.termguicolors = true
    '';
  };
}
