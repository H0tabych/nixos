# ~/nixos-config/home-manager/sgm/programs/neovim/core/clipboard.nix
{ ... }:
{
  # Интеграция с системным буфером обмена
  clipboard.providers.wl-copy.enable = true;
}
