# ~/nixos-config/home-manager/sgm/programs/foot.nix
{ config, pkgs, ... }:
{
  # Устанавливаем шрифт (должен быть доступен в системе)
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=8";
        dpi-aware = "yes";
        pad = "10x10";
      };

      colors = {
        # Прозрачность фона (0.85 = 85% непрозрачности)
        alpha = "0.85";

        background = "121212";
        foreground = "e0e0e0";

        regular0  = "1e1e1e";
        regular1  = "ef4444";
        regular2  = "4ade80";
        regular3  = "fbbf24";
        regular4  = "60a5fa";
        regular5  = "c084fc";
        regular6  = "22d3ee";
        regular7  = "e0e0e0";

        bright0   = "3a3a3a";
        bright1   = "f87171";
        bright2   = "86efac";
        bright3   = "fde047";
        bright4   = "93c5fd";
        bright5   = "d8b4fe";
        bright6   = "67e8f9";
        bright7   = "ffffff";

        # Курсор: строка "foreground background"
        cursor = "4ade80 121212";
      };

      scrollback = {
        lines = 10000;
        multiplier = 3;
      };
    };
  };
}
