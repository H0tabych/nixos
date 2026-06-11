{
  config,
  pkgs,
  lib,
  ...
}: let
  # Директория с переносимой конфигурацией
  zshConfigDir = ./zsh-config;
in {
  # ===== ЗАВИСИМОСТИ =====
  home.packages = with pkgs; [
    bc # Для расчёта времени выполнения команд (тема passion)
    coreutils # Для date с миллисекундами
  ];

  # ===== OH-MY-ZSH И ПЛАГИНЫ (через нативную поддержку HM) =====
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    # Oh-My-Zsh
    oh-my-zsh = {
      enable = true;
      theme = "passion";
      plugins = ["git" "docker" "kubectl" "systemd"];
      # Директория с кастомными темами и плагинами
      custom = "${zshConfigDir}/oh-my-zsh-custom";
    };

    # Дополнительные плагины (не из oh-my-zsh)
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1885w3crr503h5n039kmg199sikb1vw1fvaidwr21sj9mn01fs9a";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "0g8rp7pc6yy8wn3bzhxh7n8r4j3qyxkj7501ixwa1hhhqbgxxjal";
        };
      }
    ];

    # Переменные окружения (загружаются первыми)
    envExtra = builtins.readFile "${zshConfigDir}/env.zsh";

    # Основная конфигурация (загружается после oh-my-zsh)
    initContent = builtins.readFile "${zshConfigDir}/init.zsh";

    # Профиль для login shells
    profileExtra = builtins.readFile "${zshConfigDir}/profile.zsh";
  };
}
