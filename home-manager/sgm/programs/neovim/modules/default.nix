# ~/nixos-config/home-manager/sgm/programs/neovim/modules/default.nix
{
  imports = [
    ./completion.nix
    ./lsp.nix
    ./dap.nix
    ./formatting.nix
    ./editor.nix
    ./ui.nix
  ];
}
