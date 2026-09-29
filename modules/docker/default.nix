# ~/nixos-config/modules/docker/default.nix
{...}: {
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
}
