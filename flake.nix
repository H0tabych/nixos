# ~/nixos-config/flake.nix
{
  description = "NixOS configuration for my laptop with Hyprland and NVIDIA";

  # Входные данные (inputs): откуда мы берём код
  inputs = {
    # Стабильная версия NixOS 25.11
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Модуль для управления пользовательским окружением
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # Говорим, чтобы home-manager использовал ту же версию nixpkgs, что и мы
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Модуль для настройки "неуничтожимости" (impermanence)
    impermanence.url = "github:nix-community/impermanence";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  # Выходные данные (outputs): что мы строим на основе входов
  outputs = { self, nixpkgs, home-manager, impermanence, hyprland, nixvim, ... }@inputs: 
  let
    # Определяем общие переменные в блоке let...in
    system = "x86_64-linux";
    user = "sgm";
    nixosVersion = "25.11";
  in
  {
    # Определяем конфигурацию NixOS для нашего хоста "sgms-laptop"
    nixosConfigurations.sgms-laptop = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs user nixosVersion;
      };
      # Список модулей, из которых собирается конфигурация
      modules = [
        # 1. Импортируем нашу хост-конфигурацию
        ./hosts/sgms-laptop
        # 2. Подключаем модуль home-manager как модуль NixOS
        home-manager.nixosModules.home-manager
        # 3. Подключаем модуль impermanence
        impermanence.nixosModules.impermanence
        # 4. В будущем добавим модуль для Hyprland
        hyprland.nixosModules.default
        # 5. Настройка home-manager: делаем его доступным для всех пользователей
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            # Здесь мы будем импортировать конфигурации пользователей
            users.${user} = import ./home-manager/${user}/home.nix;
	        extraSpecialArgs = { inherit user nixosVersion ; };
	        sharedModules = [ nixvim.homeModules.nixvim ];
          };
        }
      ];
    };
  };
}
