# ~/nixos-config/home-manager/sgm/programs/hypr-ui/default.nix
{ config, pkgs, ... }:

{
  imports = [
    ./rofi.nix
  ];

  # Можно добавить общие пакеты, если они нужны нескольким компонентам
  home.packages = with pkgs; [ ];
}
