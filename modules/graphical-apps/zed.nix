# ~/nixos-config/modules/graphical-apps/zed.nix
{pkgs, ...}: {
  # Устанавливаем Zed
  environment.systemPackages = with pkgs; [
    zed-editor
  ];

  # Переменные окружения для корректной работы в Wayland
  environment.sessionVariables = {
    WINIT_UNIX_BACKEND = "wayland"; # Отключаем X11-бэкенд
    WGPU_BACKEND = "vulkan"; # Аппаратное ускорение
  };
}
