# ~/nixos-config/hosts/sgms-laptop/system.nix
{...}: {
  # --- ЗАГРУЗЧИК ---
  # Используем systemd-boot (простой и надёжный загрузчик для UEFI-систем)
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # --- ЯДРО ---
  # Включаем поддержку последних версий ядра (необязательно, но полезно)
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.networkmanager.enable = true;

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
    # Steam требует эти порты (раскомментируйте если нужен):
    allowedTCPPortRanges = [
      {
        from = 27030;
        to = 27031;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 27000;
        to = 27100;
      }
    ];
  };

  # Laptop-specific optimizations
  services.tlp.enable = true;

  # Keyboard layout
  services.xserver = {
    xkb.layout = "us,ru";
    xkb.options = "grp:alt_shift_toggle";
  };
  console = {
    font = "LatArCyrHeb-16";
    keyMap = "us"; # Или "ru", если нужна русская раскладка в консоли
  };

  # --- ПОДКАЧКА (SWAP) ---
  # Подключаем созданный ранее файл подкачки
  swapDevices = [
    {
      device = "/swap/swapfile";
    }
  ];

  # --- ФАЙЛОВЫЕ СИСТЕМЫ (ОПТИМИЗАЦИЯ BTRFS) ---
  fileSystems = {
    "/".options = ["compress=zstd:1" "noatime" "discard=async"];
    "/home".options = ["compress=zstd:1" "noatime" "discard=async"];
    "/nix".options = ["compress=zstd:1" "noatime" "discard=async"];
    "/persist" = {
      options = ["compress=zstd:1" "noatime" "discard=async"];
      neededForBoot = true;
    };
    "/swap".options = ["noatime" "nodatacow"];
  };

  # Автоматическая проверка Btrfs раз в месяц
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

  # Ограничиваем количество отображаемых поколений при загрузке до 10.
  # systemd-boot автоматически удалит самые старые, когда будет достигнут этот лимит.
  boot.loader.systemd-boot.configurationLimit = 10;
}
