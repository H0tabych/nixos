# Системный модуль для direnv и nix-ld
# Примечание: Это NixOS-модуль, не Home Manager
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
    ];
  };
}
