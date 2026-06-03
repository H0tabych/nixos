# ~/nixos-config/modules/gaming/default.nix
{
  config,
  pkgs,
  user,
  ...
}: {
  # 2. Включаем GameMode для автоматической оптимизации системы при запуске игр
  programs.gamemode.enable = true;

  # 3. Настройка Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Открываем порты для Steam Remote Play
    dedicatedServer.openFirewall = true; # Открываем порты для выделенного сервера
    localNetworkGameTransfers.openFirewall = true; # Открываем порты для передачи игр по локальной сети
    gamescopeSession.enable = false; # Не запускаем Steam в отдельном сеансе gamescope (пока)
    extraCompatPackages = with pkgs; [
      proton-ge-bin # Декларативно добавляем Proton-GE в список совместимости Steam
    ];
  };

  # 4. Установка системных пакетов, связанных с играми
  environment.systemPackages = with pkgs; [
    # Утилиты для мониторинга и настройки
    mangohud
    goverlay # GUI для настройки MangoHud

    # Инструменты для запуска игр
    lutris # Лаунчер для игр не из Steam
    wineWowPackages.stagingFull # Последняя версия Wine для запуска Windows-игр
    winetricks # Помощник для настройки Wine

    # Дополнительные 32-битные библиотеки для MangoHud
    # mangohud32     # 32-битная версия MangoHud для старых игр
    pkgsi686Linux.mangohud

    # Инструменты Vulkan
    vulkan-tools # Утилиты командной строки для Vulkan (vulkaninfo и др.)

    # Дополнительные компоненты для улучшения совместимости
    dxvk # Трансляция DirectX 9/10/11 в Vulkan
    vkd3d # Трансляция DirectX 12 в Vulkan
    protonup-qt # GUI для установки и управления Proton-GE
  ];

  # 5. Важное исправление для NVIDIA и XWayland (устранение разрывов)
  # Включаем экспорт конфигурации Xorg, чтобы XWayland получил правильные настройки
  services.xserver.exportConfiguration = true;

  # 6. Дополнительные переменные окружения для улучшения работы
  environment.sessionVariables = {
    # Указываем Steam, где искать кастомные Proton (если ставите вручную)
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${user}/.steam/root/compatibilitytools.d";
  };
}
