{
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;

    # Используем пакет из NixOS-модуля (не дублируем)
    package = null;
    portalPackage = null;

    # Важно для systemd-сервисов
    systemd.enable = true;
    systemd.variables = ["--all"];

    # Включаем XWayland для совместимости
    xwayland.enable = true;

    # Конфигурация в формате Nix (конвертируется в Lua/INI)
    settings = {
      # === ENVIRONMENT VARIABLES ===
      env = [
        "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
        "GBM_BACKEND,nvidia-drm"
        "__GL_GSYNC_ALLOWED,1"
        "__GL_VRR_ALLOWED,1"
        "HYPRCURSOR_SIZE,16"
        "XCURSOR_SIZE,16"
        "NIXOS_OZONE_WL,1"
      ];

      # === MONITORS ===
      # monitor = [
      #   "eDP-1, 1920x1080@60, 0x0, 1"
      # ];

      # === GENERAL ===
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

      # === DECORATION ===
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

      # === ANIMATIONS ===
      animations = {
        enabled = true; # Было: "yes, please :)" — теперь только boolean

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
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
          "zoomFactor, 1, 7, quick"
        ];
      };

      # === DWINDLE LAYOUT ===
      dwindle = {
        # pseudotile удалён — не указываем
        preserve_split = true;
      };

      # === MASTER LAYOUT ===
      master = {
        new_status = "master";
      };

      # === MISC ===
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
        # disable_splash_rendering = true; # опционально
      };

      # === VARIABLES ===
      "$mod" = "SUPER";
      "$terminal" = "foot";
      "$fileManager" = "yazi";
      "$browser" = "firefox";

      # === KEYBINDINGS ===
      bind =
        [
          # Основные
          "$mod, C, killactive"
          "$mod, V, togglefloating"
          "$mod, Q, exit"
          "$mod, Return, exec, $terminal"
          "$mod, B, exec, $browser"
          "$mod, F, exec, $terminal -e $fileManager"

          # Навигация
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # Скриншот
          ", Print, exec, ~/.local/bin/screenshot"

          # Rofi
          "$mod, R, exec, rofi -show drun -show-icons"

          # Swayimg
          "$mod, I, exec, swayimg"

          # Буфер обмена
          "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        ]
        # Генерация биндов для воркспейсов 1-9
        ++ (builtins.concatLists (builtins.genList (i: let
            ws = builtins.toString (i + 1);
          in [
            "$mod, code:1${builtins.toString i}, workspace, ${ws}"
            "$mod SHIFT, code:1${builtins.toString i}, movetoworkspace, ${ws}"
          ])
          9));

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Media keys (exec-once)
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Media keys (latched)
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # === INPUT ===
      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      # === WINDOW RULES (НОВЫЙ СИНТАКСИС 0.53+) ===
      # Используем windowrulev2 с анонимным синтаксисом
      windowrulev2 = [
        # Подавить maximize события для всех окон
        "suppressevent maximize, class:.*"

        # Fix XWayland dragging issues
        "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"

        # Переместить hyprland-run в нужное место
        "move 20 monitor_h-120, class:hyprland-run"
        "float, class:hyprland-run"

        # Пример: сделать окно терминала плавающим по умолчанию
        # "float, class:kitty, title:popup"
      ];

      # === LAYER RULES ===
      layerrule = [
        "blur, waybar"
        "ignorealpha 0.2, waybar"
        "blur, rofi"
      ];

      # === EXEC ON STARTUP ===
      exec-once = [
        "kanshi"
        "waybar"
        "hyprpaper"
        "hypridle"
        "swayosd"
        "wl-paste --watch cliphist store"
        # Важно для systemd-сервисов
        "dbus-update-activation-environment --systemd --all"
      ];
    };
  };

  # === KANSHI CONFIGURATION ===
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = [
      {
        profile = {
          name = "mobile";
          outputs = [
            {
              criteria = "eDP-1";
              mode = "1920x1080@60";
              position = "0,0";
              scale = 1.0;
            }
          ];
        };
      }
      {
        profile = {
          name = "home";
          outputs = [
            {
              criteria = "eDP-1";
              mode = "1920x1080@60";
              position = "0,0";
              scale = 1.0;
            }
            {
              criteria = "HDMI-A-1";
              mode = "1920x1080@60";
              position = "1920,0";
              scale = 1.0;
            }
          ];
        };
      }
      {
        profile = {
          name = "desktop";
          outputs = [
            {
              criteria = "HDMI-A-1";
              mode = "1920x1080@60";
              position = "1920,0";
              scale = 1.0;
            }
          ];
        };
      }
    ];
  };
}
