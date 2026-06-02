# ~/nixos-config/modules/automount/default.nix
{ config, pkgs, lib, user, ... }:

{
  # === СЕРВИСЫ ДЛЯ АВТОМОНТИРОВАНИЯ ===
  # UDisks2 – управление дисками
  services.udisks2.enable = true;

  # GVfs – монтирование томов в пользовательском пространстве
  services.gvfs.enable = true;

  # DBus – уже должен быть включён, но явно указываем для уверенности
  services.dbus.enable = true;

  # === ПРАВА ПОЛЬЗОВАТЕЛЯ ===
  # Добавляем пользователя в группу storage для доступа к дискам
  users.users.${user}.extraGroups = [ "storage" ];
}
