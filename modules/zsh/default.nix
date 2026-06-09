# ~/nixos-config/modules/zsh/default.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  # 1. Включаем программу Zsh на системном уровне.
  #    Это решает проблему безопасности: Zsh регистрируется в /etc/shells,
  #    и NixOS знает, что эта оболочка полностью настроена и безопасна.
  programs.zsh.enable = true;

  # 2. Добавляем Zsh в список доступных оболочек (делается автоматически
  #    при programs.zsh.enable, но явное указание не помешает).
  environment.shells = with pkgs; [zsh];

  # 3. Устанавливаем Zsh как оболочку по умолчанию для всех новых пользователей.
  users.defaultUserShell = pkgs.zsh;

  # 4. Глобальные переменные окружения: устанавливаем Neovim редактором по умолчанию.
  environment.variables = {
    EDITOR = lib.mkForce "nvim";
    VISUAL = lib.mkForce "nvim";
    PAGER = lib.mkForce "less";
  };
}
