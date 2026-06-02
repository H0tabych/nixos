# ~/nixos-config/hosts/sgms-laptop/impermanence.nix
{ config, ... }:

{
  # Настройка persistent-хранилища. Все файлы и папки, указанные здесь,
  # будут сохраняться в /persist и "возвращаться" на свои места при загрузке.
  environment.persistence."/persist" = {
    hideMounts = true; # Скрываем содержимое /persist из обычного просмотра (опционально)
    directories = [
      # Системные данные, которые должны пережить перезагрузку
      "/var/lib/nixos"               # UID/GID mappings для NixOS
      "/var/lib/systemd"             # Состояние systemd (например, сиды для random)
      "/var/lib/bluetooth"           # Сопряжённые Bluetooth-устройства
      "/var/lib/NetworkManager"      # Состояние NetworkManager
      "/etc/NetworkManager/system-connections" # Сохранённые пароли Wi-Fi
      "/etc/ssh"                     # SSH-ключи хоста (критически важно!)
      "/var/log"                     # Системные логи (можно и не сохранять, но полезно для отладки)
    ];
    files = [
      "/etc/machine-id"              # Уникальный ID машины
      # "/etc/hosts"                 # Раскомментируйте, если у вас кастомные записи в hosts
    ];
  };

  # Отключаем надоедливое предупреждение sudo при первом использовании после перезагрузки
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';

  # Создаём необходимые директории в /persist
  systemd.tmpfiles.rules = [
    "d /persist 0755 root root -"
    "d /persist/home 0755 root root -"
    "d /persist/home/sgm 0750 sgm users -"
  ];
}
