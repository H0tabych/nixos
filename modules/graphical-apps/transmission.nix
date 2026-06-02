# ~/nixos-config/modules/graphical-apps/transmission.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    transmission_4-gtk   # GTK-интерфейс Transmission версии 4
  ];

  # Если вы захотите позже включить демон Transmission для работы в фоне,
  # раскомментируйте следующие строки:
  # services.transmission = {
  #   enable = true;
  #   package = pkgs.transmission_4;
  #   settings = {
  #     download-dir = "/home/sgm/Downloads";
  #     rpc-whitelist = "127.0.0.1";
  #   };
  # };
}
