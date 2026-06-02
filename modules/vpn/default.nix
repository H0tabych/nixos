# ~/nixos-config/modules/vpn/default.nix
{ config, pkgs, ... }:

{
  # Активируем NetworkManager (возможно, он уже активен)
  networking.networkmanager.enable = true;

  # Устанавливаем плагины для NetworkManager.
  # networkmanager-openvpn необходим для поддержки вашего .ovpn файла
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];
}
