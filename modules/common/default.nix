{
  config,
  pkgs,
  lib,
  user,
  stateVersion,
  ...
}: {
  # Nix settings
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" user];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
  };

  # System-wide locale and timezone
  time.timeZone = lib.mkDefault "Europe/Moscow";
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  # User configuration
  users.users.${user} = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = ["wheel" "networkmanager" "video" "audio"];
    shell = pkgs.zsh;
  };

  # Allow unfree packages (needed for NVIDIA, Steam, etc.)
  nixpkgs.config.allowUnfree = true;

  # State version (не менять после первой установки!)
  system.stateVersion = stateVersion;
}
