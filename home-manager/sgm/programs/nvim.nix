{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Базовые утилиты для плагинов
    git
    ripgrep
    fd
    gcc
    gnumake
    curl
    wget
    unzip
    gnutar
    tree-sitter

    # === LSP СЕРВЕРЫ (актуальные имена для nixpkgs 25.11) ===
    pyright                          # Python (раньше был nodePackages.pyright)
    nil                              # Nix
    nodePackages.vscode-langservers-extracted  # HTML, CSS, JSON, ESLint
    yaml-language-server             # YAML (может быть nodePackages.yaml-language-server)
    bash-language-server             # Bash (может быть nodePackages.bash-language-server)
    sqls                             # SQL
    nodePackages.typescript-language-server    # TypeScript/JavaScript

    # === ФОРМАТТЕРЫ И ЛИНТЕРЫ (для none-ls) ===
    mypy                             # Python type checker
    black                            # Python formatter
    isort                            # Python import sorter
    clang-tools                      # C/C++ formatter/linter
    stylua                           # Lua formatter
    nixfmt-rfc-style                 # Nix formatter (или nixfmt)

    # === ЗАВИСИМОСТИ ДЛЯ MASON (опционально) ===
    nodejs
    go
    rustc
    cargo
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
