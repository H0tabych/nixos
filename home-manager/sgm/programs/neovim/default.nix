# ~/nixos-config/home-manager/sgm/programs/neovim/default.nix
{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    imports = [
      ./core
      ./modules
    ];
  };
 
  # Дополнительные пакеты для языков (вне nixvim)
  imports = [
    ./languages
  ];
}
