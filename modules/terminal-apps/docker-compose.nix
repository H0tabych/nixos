# ~/nixos-config/modules/terminal-apps/docker-compose.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
