# ~/nixos-config/home-manager/sgm/programs/mako.nix
{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      default-timeout = 5000;
      layer = "overlay";
      max-visible = 5;
      sort = "-time";
      border-radius = 12;
      border-size = 1;
      margin = "10, 10, 10, 10";
      padding = "15, 20, 15, 20";
      font = "JetBrains Mono 11";
      icons = true;
      max-icon-size = 48;
      markup = true;
      actions = true;
      group-by = "app-name";

      # Цвета в hex (с альфа-каналом)
      background-color = "#121212D9";   # rgba(18, 18, 18, 0.85)
      border-color = "#4ADE8080";       # rgba(74, 222, 128, 0.5)
      text-color = "#E0E0E0";           # светло-серый
      progress-color = "#4ADE80CC";     # rgba(74, 222, 128, 0.8)
    };

    extraConfig = ''
      [urgency=low]
      border-color=#4ADE8080
      background-color=#121212D9

      [urgency=normal]
      border-color=#4ADE8080
      background-color=#121212D9

      [urgency=critical]
      border-color=#EF4444
      text-color=#EF4444
      ignore-timeout=1
    '';
  };

  systemd.user.services.mako = {
    Unit = {
      Description = "Mako notification daemon";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-failure";
      RestartSec = 2;
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
