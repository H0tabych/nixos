# ~/nixos-config/home-manager/sgm/programs/neovim/languages/default.nix
{
  imports = [
    ./python.nix
    ./cpp.nix
    ./rust.nix
    ./nix.nix
    ./lua.nix
    ./web.nix
  ];
}
