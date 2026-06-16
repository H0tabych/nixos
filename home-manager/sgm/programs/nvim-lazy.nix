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

    # === LSP СЕРВЕРЫ (правильные имена для nixpkgs 25.11) ===
    pyright                                    # Python
    nil                                        # Nix
    nodePackages.vscode-langservers-extracted  # JSON, HTML, CSS, ESLint (один пакет для всех)
    nodePackages.yaml-language-server          # YAML
    nodePackages.bash-language-server          # Bash
    sqls                                       # SQL
    nodePackages.typescript-language-server    # TypeScript/JavaScript
    lua-language-server                        # Lua
    clang-tools                                # C/C++ (clangd)

    # === ФОРМАТТЕРЫ И ЛИНТЕРЫ (для none-ls) ===
    mypy                                       # Python type checker
    black                                      # Python formatter
    isort                                      # Python import sorter
    stylua                                     # Lua formatter
    nixfmt-rfc-style                           # Nix formatter

    # === ОТЛАДЧИКИ (DAP) ===
    python311Packages.debugpy                  # Python отладчик
    lldb                                       # C/C++ отладчик

    # === ЗАВИСИМОСТИ ДЛЯ MASON (опционально) ===
    nodejs
    go
    rustc
    cargo
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
