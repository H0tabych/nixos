# ~/nixos-config/home-manager/sgm/programs/neovim/modules/lang/cpp.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang-tools
    pkgs.vscode-extensions.vadimcn.vscode-lldb
  ];
}
