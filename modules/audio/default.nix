# ~/nixos-config/modules/audio/default.nix
{ config, pkgs, lib, ... }:

{
  # === БЕЗОПАСНОСТЬ И ПРАВА РЕАЛЬНОГО ВРЕМЕНИ ===
  # RTKit даёт PipeWire права на работу в реальном времени,
  # что критически важно для минимизации задержек звука.
  security.rtkit.enable = true;

  # === ОТКЛЮЧЕНИЕ УСТАРЕВШЕГО PULSEAUDIO ===
  services.pulseaudio.enable = false; # lib.mkForce false;

  # === ОСНОВНОЙ СЕРВЕР PIPEWIRE ===
  services.pipewire = {
    enable = true;
    alsa.enable = true;          # Поддержка ALSA (низкоуровневый доступ к железу)
    alsa.support32Bit = true;    # Для 32-битных приложений (игры, старый софт)
    pulse.enable = true;         # Эмуляция PulseAudio для совместимости
    jack.enable = true;          # Для профессиональных аудио приложений (опционально)

    # Используем современный менеджер сессий WirePlumber
    wireplumber.enable = true;
  };

  # === BLUETOOTH ===
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;          # Включать адаптер при загрузке
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket"; # Разрешаем все профили
        Experimental = true;      # Для поддержки новых кодеков
      };
    };
  };

  services.blueman.enable = true; # GUI-менеджер Bluetooth (удобно для pairing)

  # === УЛУЧШЕНИЕ КАЧЕСТВА BLUETOOTH-ЗВУКА ===
  # Активируем высококачественные кодеки через конфигурацию WirePlumber
  environment.etc."wireplumber/bluetooth.lua.d/51-enable-msbc.lua".text = ''
    -- Включаем mSBC (широкополосный голос) для гарнитур
    rule = {
      matches = {
        {
          { "device.name", "matches", "bluez_card.*" },
        },
      },
      apply_properties = {
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-sbc-xq"] = true, -- Высококачественный SBC
        ["bluez5.hfp-offload-msbc"] = true,
      },
    }
    table.insert(bluez_monitor.rules, rule)
  '';

  # === УСТАНОВКА НЕОБХОДИМЫХ ПАКЕТОВ ===
  environment.systemPackages = with pkgs; [
    pavucontrol        # Микшер для управления звуком
    pamixer            # CLI-утилита для управления громкостью
    bluez-tools        # Утилиты для Bluetooth (bluetoothctl и др.)
    pulseaudio-ctl     # Дополнительные инструменты (опционально)
  ];

  # === ИНТЕГРАЦИЯ С HYPRLAND ===
  # Для захвата экрана и работы порталов
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      # xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
}
