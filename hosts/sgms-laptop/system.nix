# ~/nixos-config/hosts/sgms-laptop/system.nix
{ config, pkgs, user, nixosVersion, ... }:

{
  # --- ЗАГРУЗЧИК ---
  # Используем systemd-boot (простой и надёжный загрузчик для UEFI-систем)
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # --- ЯДРО ---
  # Включаем поддержку последних версий ядра (необязательно, но полезно)
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # --- ЛОКАЛИЗАЦИЯ ---
  time.timeZone = "Europe/Moscow"; # Укажите ваш часовой пояс
  i18n.defaultLocale = "en_US.UTF-8";

    # Add support for Russian locale
  i18n.extraLocaleSettings = {
    LC_TIME = "ru_RU.UTF-8";
    LC_CTYPE = "ru_RU.UTF-8";
  };
  
  # Install Russian locale data
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
    "all" # Install all available locales (safe option)
  ];

  console = {
    font = "LatArCyrHeb-16";
    keyMap = "us"; # Или "ru", если нужна русская раскладка в консоли
  };

  # --- ПОЛЬЗОВАТЕЛЬ sgm ---
  users.users.${user} = {
    isNormalUser = true;
    # Даём пользователю права на sudo (группа "wheel") и на управление сетью
    extraGroups = [ "input" "wheel" "networkmanager" "storage" ];
    # ВАЖНО: Пароль зададим вручную после установки командой `passwd sgm`
    # initialPassword = "changeme"; # ТОЛЬКО ДЛЯ ТЕСТИРОВАНИЯ, НЕ ДЛЯ ПРОДАКШЕНА
  };

  # --- СЕТЬ ---
  networking.networkmanager.enable = true; # Удобное управление сетью (Wi-Fi, VPN)

  # --- ПОДКАЧКА (SWAP) ---
  # Подключаем созданный ранее файл подкачки
  swapDevices = [{
    device = "/swap/swapfile";
  }];

  # --- ФАЙЛОВЫЕ СИСТЕМЫ (ОПТИМИЗАЦИЯ BTRFS) ---
  fileSystems = {
    "/".options = [ "compress=zstd:1" "noatime" "discard=async" ];
    "/home".options = [ "compress=zstd:1" "noatime" "discard=async" ];
    "/nix".options = [ "compress=zstd:1" "noatime" "discard=async" ];
    "/persist" = {
      options = [ "compress=zstd:1" "noatime" "discard=async" ];
      neededForBoot = true;
    };
    "/swap".options = [ "noatime" "nodatacow" ];
  };

  # Автоматическая проверка Btrfs раз в месяц
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

  # Ограничиваем количество отображаемых поколений при загрузке до 10.
  # systemd-boot автоматически удалит самые старые, когда будет достигнут этот лимит.
  boot.loader.systemd-boot.configurationLimit = 10;

  # Этот блок отвечает за удаление файлов пакетов, не привязанных ни к одной из оставшихся 10 конфигураций.
  nix = {
    gc = {
      automatic = true;               # Включаем автоматическую очистку
      dates = "weekly";               # Запускаем процесс еженедельно
      options = "--delete-older-than 7d"; # Удаляем поколения старше 7 дней[reference:1]
    };
    # Дополнительная оптимизация хранилища (удаление дубликатов файлов)
    optimise.automatic = true;
  };

  # --- NIX ---
  # Включаем экспериментальные функции: Flakes и новую команду `nix`
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Разрешаем установку несвободных пакетов (например, драйверов NVIDIA и Steam)
  nixpkgs.config.allowUnfree = true;

  # --- ВЕРСИЯ СИСТЕМЫ ---
  # НИКОГДА не меняйте это значение после установки!
  system.stateVersion = nixosVersion;
}
