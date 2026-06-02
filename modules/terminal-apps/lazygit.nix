# ~/nixos-config/modules/terminal-apps/lazygit.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lazygit
  ];
}
