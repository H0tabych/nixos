# ~/nixos-config/home-manager/sgm/programs/waybar/default.nix
{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    waybar
    rofi
    curl
    bc
    gnugrep
    gawk
    procps

    nerd-fonts.symbols-only
  ];

  # Размещаем конфигурационные файлы Waybar
  xdg.configFile."waybar/config.jsonc".source = ./config.jsonc;
  xdg.configFile."waybar/style.css".source = ./style.css;

  xdg.configFile."waybar/scripts/weather.sh" = {
    source = ./scripts/weather.sh;
    executable = true;
  };
  xdg.configFile."waybar/scripts/audio-brightness.sh" = {
    source = ./scripts/audio-brightness.sh;
    executable = true;
  };
  xdg.configFile."waybar/scripts/net-bluetooth.sh" = {
    source = ./scripts/net-bluetooth.sh;
    executable = true;
  };
  xdg.configFile."waybar/scripts/cpu-mem.sh" = {
    source = ./scripts/cpu-mem.sh;
    executable = true;
  };
  xdg.configFile."waybar/scripts/toggle-cpu-mem-format.sh" = {
    source = ./scripts/toggle-cpu-mem-format.sh;
    executable = true;
  };
  xdg.configFile."waybar/scripts/toggle-time.sh" = {
    source = ./scripts/toggle-time.sh;
    executable = true;
  };
  xdg.configFile."waybar/scripts/powermenu.sh" = {
    source = ./scripts/powermenu.sh;
    executable = true;
  };
}
