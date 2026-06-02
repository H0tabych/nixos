{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    hyprland.url = "github:hyprwm/Hyprland";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "sgm";
    stateVersion = "25.11"; # НЕ МЕНЯТЬ! Это версия первой установки

    # Функция для создания хоста
    mkHost = {
      hostname,
      extraModules ? [],
      extraHmModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs user stateVersion;
        };
        modules =
          [
            ./modules/common
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = {
                imports =
                  [
                    ./home-manager/${user}/home.nix
                  ]
                  ++ extraHmModules;
                home.stateVersion = stateVersion;
              };
            }
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations = {
      sgms-laptop = mkHost {
        hostname = "sgms-laptop";
        extraModules = [
          inputs.impermanence.nixosModules.impermanence
          inputs.hyprland.nixosModules.default
        ];
        extraHmModules = [
          inputs.nixvim.homeManagerModules.nixvim
        ];
      };

      # Пример для будущего сервера:
      # server = mkHost {
      #   hostname = "server";
      #   extraModules = [ ];
      # };
    };
  };
}
