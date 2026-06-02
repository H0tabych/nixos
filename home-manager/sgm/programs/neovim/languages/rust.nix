# ~/nixos-config/home-manager/sgm/programs/neovim/modules/lang/rust.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rust-analyzer
    rustfmt
  ];
}
