# ~/nixos-config/home-manager/sgm/programs/neovim/modules/ui.nix
{pkgs, ...}: {
  colorschemes.tokyonight = {
    enable = true;
    settings = {
      style = "night";
      transparent = true;
    };
  };

  plugins = {
    # Основной which-key (рисует окно подсказок)
    which-key.enable = true;

    telescope = {
      enable = true;
      extensions.fzf-native.enable = true;
    };

    snacks = {
      enable = true;
      settings = {
        explorer = {
          enabled = true;
          replace_netrw = true;
          hidden = true; # показывать скрытые файлы
        };
        picker.enabled = true;
        notifier.enabled = true;
        # Интеграция с which-key (даёт иконки, стиль уведомлений)
        which_key = {
          enabled = true;
        };
      };
    };

    lazygit.enable = true;
    web-devicons.enable = true;
  };
}
