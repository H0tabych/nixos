# ~/nixos-config/home-manager/sgm/hyprland.nix
{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    settings = {
      # Сюда можно перенести все настройки из hyprland.conf
      env = [
        "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
        "GBM_BACKEND,nvidia-drm"
        "__GL_GSYNC_ALLOWED,1"
        "__GL_VRR_ALLOWED,1"
        "HYPRCURSOR_SIZE,16"
        "XCURSOR_SIZE,16"
      ];
      #monitor = [
      #  "eDP-1, 1920x1080@60, 0x0, 1"
      #];

      general = {
        gaps_in = 3;
        gaps_out = 10;

        border_size = 1;

        # https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 5;
        rounding_power = 1;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        # https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      # правило для размытия панели
      #layerrule = [
      #  "blur on, match:namespace foot"
      #  "blur on, match:namespace waybar"
      # "ignorealpha 0.2, match:namespace waybar"
      #];

      animations = {
        enabled = "yes, please :)";

        # Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
        bezier = [
          #  NAME,           X0,   Y0,   X1,   Y1
          "easeOutQuint,   0.23, 1,    0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear,         0,    0,    1,    1"
          "almostLinear,   0.5,  0.5,  0.75, 1"
          "quick,          0.15, 0,    0.1,  1"
        ];

        # Default animations, see https://wiki.hypr.land/Configuring/Animations/
        animation = [
          #  NAME,          ONOFF, SPEED, CURVE,        [STYLE]
          "global,        1,     10,    default"
          "border,        1,     5.39,  easeOutQuint"
          "windows,       1,     4.79,  easeOutQuint"
          "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
          "windowsOut,    1,     1.49,  linear,       popin 87%"
          "fadeIn,        1,     1.73,  almostLinear"
          "fadeOut,       1,     1.46,  almostLinear"
          "fade,          1,     3.03,  quick"
          "layers,        1,     3.81,  easeOutQuint"
          "layersIn,      1,     4,     easeOutQuint, fade"
          "layersOut,     1,     1.5,   linear,       fade"
          "fadeLayersIn,  1,     1.79,  almostLinear"
          "fadeLayersOut, 1,     1.39,  almostLinear"
          "workspaces,    1,     1.94,  almostLinear, fade"
          "workspacesIn,  1,     1.21,  almostLinear, fade"
          "workspacesOut, 1,     1.94,  almostLinear, fade"
          "zoomFactor,    1,     7,     quick"
        ];
      };

      # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
      dwindle = {
        # pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hypr.land/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
      };

      "$mod" = "SUPER";
      "$terminal" = "foot";
      "$fileManager" = "yazi";
      # "$menu" = "hyprlauncher";
      "$browser" = "firefox";
      bind =
        [
          "$mod, C, killactive"
          "$mod, V, togglefloating"
          "$mod, Q, exit"
          "$mod, Return, exec, $terminal"
          "$mod, B, exec, $browser"
          "$mod, F, exec, $terminal -e $fileManager"

          # Смена фокуса между окнами
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # Скриншот области с аннотацией
          ", Print, exec, ~/.local/bin/screenshot"
          # Лаунчер rofi
          "$mod, R, exec, rofi -show drun -show-icons"
          # Запуск swayimg
          "$mod, I, exec, swayimg"
          # История буфера
          "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        ]
        ++ (builtins.concatLists (builtins.genList (i: let
            ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
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
      };

      # See https://wiki.hypr.land/Configuring/Gestures
      gesture = "3, horizontal, workspace";

      # Example per-device config
      # See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
      # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

      # Example windowrules that are useful
      windowrule = [
        {
          # Ignore maximize requests from all apps. You'll probably like this.
          name = "suppress-maximize-events";
          "match:class" = ".*";

          suppress_event = "maximize";
        }
        {
          # Fix some dragging issues with XWayland
          name = "fix-xwayland-drags";
          "match:class" = "^$";
          "match:title" = "^$";
          "match:xwayland" = true;
          "match:float" = true;
          "match:fullscreen" = false;
          "match:pin" = false;

          no_focus = true;
        }
        {
          name = "move-hyprland-run";

          "match:class" = "hyprland-run";

          move = "20 monitor_h-120";
          float = "yes";
        }
      ];

      exec-once = [
        "kanshi"
        "waybar"
        "hyprpaper"
        "hypridle"
        "swayosd"
        "wl-paste --watch cliphist store" # Интеграция cliphist
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
    };
  };

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
