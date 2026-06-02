# ~/nixos-config/modules/nvidia/default.nix
{ config, pkgs, lib, ... }:

{
  # --- Базовая поддержка OpenGL ---
  hardware.graphics = {
    enable = true;       # Включаем поддержку OpenGL
    enable32Bit = true;  # Включаем поддержку 32-битных приложений (для игр и Steam)
  };

  # --- Основная конфигурация драйвера NVIDIA ---
  hardware.nvidia = {
    # Включаем режим modesetting, необходимый для работы Wayland
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # Используем открытые модули ядра NVIDIA (рекомендовано для GTX 1650)
    # Для архитектуры Turing и новее это лучший выбор.
    open = true;

    # Устанавливаем утилиту для настройки параметров видеокарты
    nvidiaSettings = true;

    # Используем стабильную ветку драйверов
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # --- Настройка гибридной графики (Prime Offload) ---
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true; # Добавляет команду 'nvidia-offload'
      };
      # Указываем PCI-идентификаторы, полученные на шаге 1
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # --- Драйверы для Xorg и Wayland ---
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  # --- Правила udev для управления питанием NVIDIA (рекомендовано) ---
  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    # Enable runtime PM for NVIDIA VGA/3D controller
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", ATTR{power/control}="auto"
  '';
}
