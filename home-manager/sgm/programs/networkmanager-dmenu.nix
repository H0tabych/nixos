# ~/nixos-config/home-manager/sgm/programs/networkmanager-dmenu.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    networkmanager_dmenu
  ];

  # Конфигурация для networkmanager-dmenu
  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi -dmenu -i -theme glassmorphism
  '';
}
