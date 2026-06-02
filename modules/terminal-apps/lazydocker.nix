# ~/nixos-config/modules/terminal-apps/lazydocker.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lazydocker
  ];
}
