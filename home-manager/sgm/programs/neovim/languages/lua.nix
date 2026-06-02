# ~/nixos-config/home-manager/sgm/programs/neovim/modules/lang/python.nix
{pkgs, ...}: {
  home.packages = with pkgs; [
    stylua
  ];
}
