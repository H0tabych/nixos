# ~/nixos-config/home-manager/sgm/programs/zed.nix
{...}: {
  xdg.configFile."zed/settings.json".text = builtins.toJSON {
    theme = "One Dark";
    ui_font_family = "JetBrainsMono Nerd Font";
    ui_font_size = 14;
    buffer_font_size = 14;
    autosave = "off";
    format_on_save = "on";

    lsp = {
      nil = {};
      pyright = {};
      ruff = {};
      rust-analyzer = {};
      clangd = {};
    };

    languages = {
      Nix = {
        language_servers = ["nil"];
        formatter = {
          external = {
            command = "alejandra";
            arguments = [];
          };
        };
      };
      Python = {
        language_servers = ["pyright"];
        formatter = {
          external = {
            command = "ruff";
            arguments = ["format" "-"]; # убрана запятая после "-"
          };
        };
      };
    };
  };
}
