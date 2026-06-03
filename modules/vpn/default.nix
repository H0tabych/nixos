# ~/nixos-config/modules/vpn/default.nix
{
  config,
  pkgs,
  ...
}: {
  # Устанавливаем плагины для NetworkManager.
  # networkmanager-openvpn необходим для поддержки вашего .ovpn файла
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];
}
