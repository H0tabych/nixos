# ~/nixos-config/modules/graphical-apps/dbeaver.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dbeaver-bin
  ];
}
