# ~/nixos-config/modules/graphical-apps/firefox.nix
{ config, pkgs, ... }:

{
  # Устанавливаем Firefox как обычный пакет
  environment.systemPackages = with pkgs; [ firefox ];
}
