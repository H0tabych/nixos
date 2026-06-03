# ~/nixos-config/hosts/sgms-laptop/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # --- Основные утилиты ---
    git # Система контроля версий
    neovim # Основной текстовый редактор
    wget
    curl
    tree
    btop # Красивый мониторинг ресурсов
    pciutils # Утилиты для работы с PCI-устройствами (lspci)
    usbutils # Утилиты для работы с USB-устройствами (lsusb)

    # --- Сеть и безопасность ---
    openssh # SSH-клиент и сервер
    nmap # Сканер сети

    # --- Инструменты для разработки (C++, Python, SQL) ---
    uv
    gcc # Компилятор C
    gnumake # Утилита сборки make
    cmake # Кроссплатформенная система сборки
    python3 # Интерпретатор Python
    # sqlite              # Легковесная реляционная БД

    # Laptop utilities
    brightnessctl
    acpi
  ];
}
