# ~/nixos-config/home-manager/sgm/programs/hyprpaper.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ hyprpaper ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "/home/sgm/Pictures/workspaces/workspace.jpg" ];
      wallpaper = [ ",/home/sgm/Pictures/workspaces/workspace.jpg" ];
    };
  };
}
