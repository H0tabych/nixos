{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Базовые утилиты
    git ripgrep fd gcc gnumake curl wget unzip gnutar tree-sitter

    # LSP серверы (установлены через Nix)
    pyright nil json-language-server yaml-language-server
    bash-language-server sqls typescript-language-server
    html-css-class-completion clang-tools stylua nixfmt-rfc-style

    # Отладчики
    python311Packages.debugpy lldb

    # Зависимости для Mason (на случай, если понадобится)
    nodejs go rustc cargo
  ];

  # Связываем портативную конфигурацию
  xdg.configFile."nvim".source = ./nvim-lazy-config;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Полностью отключаем генерацию HM
    extraConfig = "";
    extraLuaConfig = "";
    extraPackages = [];
  };
}
