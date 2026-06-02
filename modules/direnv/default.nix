# ~/nixos-config/modules/direnv/default.nix
{...}: {
  # Включаем direnv и интеграцию с Zsh в Home Manager
  programs.direnv = {
    enable = true;
    enableZshIntegration = true; # Автоматически загружать direnv в Zsh
    nix-direnv.enable = true; # Быстрая загрузка Nix-окружений
  };
  programs.nix-ld.enable = true;
}
