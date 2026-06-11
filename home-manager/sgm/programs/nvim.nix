{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Базовые утилиты для плагинов
    git ripgrep fd gcc gnumake curl wget unzip gnutar tree-sitter
    
    # === LSP СЕРВЕРЫ (Устанавливаются через Nix = 100% надежность) ===
    nodePackages.pyright          # Python
    nil                           # Nix
    nodePackages.json-language-server # JSON
    yaml-language-server          # YAML
    bash-language-server          # Bash
    sqls                          # SQL
    nodePackages.typescript-language-server # TypeScript/JavaScript
    nodePackages.vscode-langservers-extracted # HTML, CSS, CSSLS
    
    # === ФОРМАТТЕРЫ И ЛИНТЕРЫ (для none-ls) ===
    mypy                          # Python type checker
    black                         # Python formatter
    isort                         # Python import sorter
    clang-tools                   # C/C++ formatter/linter
    stylua                        # Lua formatter
    nixfmt-rfc-style              # Nix formatter
    
    # === ЗАВИСИМОСТИ ДЛЯ MASON (на случай, если вы захотите установить что-то вручную) ===
    nodejs go rustc cargo
  ];

  # Портативная конфигурация
  xdg.configFile."nvim".source = ./nvim-config;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
