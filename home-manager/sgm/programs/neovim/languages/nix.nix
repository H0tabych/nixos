# ~/nixos-config/home-manager/sgm/programs/neovim/modules/lang/nix.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alejandra
    nil
  ];
}
