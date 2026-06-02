# ~/nixos-config/home-manager/sgm/programs/neovim/modules/completion.nix
{...}: {
  plugins = {
    blink-cmp.enable = true;
    blink-cmp-copilot.enable = true;
  };
}
