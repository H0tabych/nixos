# ~/nixos-config/home-manager/sgm/programs/hypr-security.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hypridle          # Демон бездействия
    hyprlock          # Экран блокировки
    hyprpolkitagent   # Агент аутентификации для GUI
  ];

  # Сервисы systemd для пользователя
  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprland Polkit Authentication Agent";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Конфигурация hypridle
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
      };
      listener = [
        {
          timeout = 300;  # 5 минут
          on-timeout = "brightnessctl -s set 10%";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 600;  # 10 минут
          on-timeout = "hyprlock & sleep 1 && systemctl suspend";
        }
      ];
    };
  };

  # Конфигурация hyprlock (базовая)
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };
      background = {
        monitor = "";
        path = "~/wallpaper.png";  # Укажите путь к обоям блокировки
      };
      input-field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgba(0,0,0,0)";
        inner_color = "rgba(0,0,0,0.5)";
        font_color = "rgb(200,200,200)";
        fade_on_empty = false;
        placeholder_text = "Password...";
        hide_input = false;
      };
    };
  };
}
