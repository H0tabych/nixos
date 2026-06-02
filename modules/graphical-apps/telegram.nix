# ~/nixos-config/modules/graphical-apps/telegram.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    telegram-desktop
  ];
}
