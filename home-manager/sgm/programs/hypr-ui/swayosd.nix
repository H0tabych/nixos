# ~/nixos-config/home-manager/sgm/programs/hypr-ui/swayosd.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    swayosd
  ];

  # Конфигурация через xdg.configFile
  xdg.configFile."swayosd/config".text = ''
    # SwayOSD configuration
    max-volume = 150
    timeout = 2
  '';

  # Запуск swayosd через systemd (или можно оставить exec-once в hyprland.nix)
  systemd.user.services.swayosd = {
    Unit = {
      Description = "SwayOSD daemon";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swayosd}/bin/swayosd";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
