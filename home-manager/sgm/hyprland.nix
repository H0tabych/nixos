# ~/nixos-config/home-manager/sgm/hyprland.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    configType = "lua"; # Используем современный Lua-генератор Home Manager
    systemd.enable = false; # КРИТИЧНО: отключаем HM systemd, так как используем UWSM на уровне системы

    settings = {
      env = [
        "AQ_DRM_DEVICES,/dev/dri/by-path/pci-0000:01:00.0-card:/dev/dri/by-path/pci-0000:00:02.0-card" # Более надёжный путь, чем card1:card0
        "GBM_BACKEND,nvidia-drm"
        "__GL_GSYNC_ALLOWED,1"
        "__GL_VRR_ALLOWED,1"
        "HYPRCURSOR_SIZE,16"
        "XCURSOR_SIZE,16"
        "NIXOS_OZONE_WL,1"
        "http_proxy,http://127.0.0.1:10809"
        "https_proxy,http://127.0.0.1:10809"
        "no_proxy,localhost,127.0.0.1,::1,.local,/run/user,/tmp" # Важно для работы локального DBus/Wayland
      ];

      general = {
        gaps_in = 3;
        gaps_out = 10;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        blur = {
          enabled = true;
          size = 5;
          passes = 1;
          vibrancy = 0.1696;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1"
          "quick, 0.15, 0, 0.1, 1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "workspaces, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      "$mod" = "SUPER";
      "$terminal" = "foot";
      "$fileManager" = "yazi";
      "$browser" = "firefox";

      bind =
        [
          "$mod, C, killactive"
          "$mod, V, togglefloating"
          "$mod, Q, exit"
          "$mod, Return, exec, $terminal"
          "$mod, B, exec, $browser"
          "$mod, F, exec, $terminal -e $fileManager"
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"
          ", Print, exec, ~/.local/bin/screenshot"
          "$mod, R, exec, rofi -show drun -show-icons"
          "$mod, I, exec, swayimg"
          "$mod SHIFT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        ]
        ++ (builtins.concatLists (builtins.genList (i: let
            ws = builtins.toString (i + 1);
          in [
            "$mod, code:1${builtins.toString i}, workspace, ${ws}"
            "$mod SHIFT, code:1${builtins.toString i}, movetoworkspace, ${ws}"
          ])
          9));

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      # Новый синтаксис правил для Hyprland 0.53+
      windowrule = [
        "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
        "move 20 monitor_h-120, class:hyprland-run"
        "float, class:hyprland-run"
      ];

      layerrule = [
        "blur, match:namespace waybar"
        "ignorealpha 0.2, match:namespace waybar"
        "blur, match:namespace rofi"
      ];

      # Оставляем в exec-once только то, у чего нет нативного systemd-модуля в HM
      exec-once = [
        "waybar"
        "dbus-update-activation-environment --systemd --all"
      ];
    };
  };

  # --- НАТИВНЫЕ МОДУЛИ HOME MANAGER (заменяют ручные systemd-юниты и exec-once) ---
  
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = [
      {
        profile = {
          name = "mobile";
          outputs = [{ criteria = "eDP-1"; mode = "1920x1080@60"; position = "0,0"; scale = 1.0; }];
        };
      }
    ];
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/home/sgm/Pictures/workspaces/workspace.jpg" ]; # Убедитесь, что путь верный
      wallpaper = [ "eDP-1, /home/sgm/Pictures/workspaces/workspace.jpg" ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        { timeout = 600; on-timeout = "loginctl lock-session"; }
        { timeout = 660; on-timeout = "hyprctl dispatch dpms off"; on-resume = "hyprctl dispatch dpms on"; }
      ];
    };
  };

  services.cliphist = {
    enable = true;
    # Нативный модуль сам создаст правильный сервис с wl-paste --watch
  };

  services.swayosd = {
    enable = true;
    # Нативный модуль сам создаст правильный сервис с swayosd-server
  };
}
