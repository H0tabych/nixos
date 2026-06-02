# ~/nixos-config/modules/graphical-apps/postman.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    postman
  ];
}
