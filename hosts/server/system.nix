{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  networking.hostName = "server";

  # Минимальный firewall для сервера
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22]; # SSH
    allowedUDPPorts = [];
  };

  # Включить SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Сервер не нуждается в графических пакетах
  # Не импортируем hyprland, nvidia, gaming и т.д.
}
