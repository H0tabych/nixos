# ~/nixos-config/home-manager/sgm/programs/neovim/modules/lsp.nix
{pkgs, ...}: {
  plugins = {
    lsp = {
      enable = true;
      # keymaps больше нет – всё в core/keymaps.nix
      servers = {
        nil_ls = {
          enable = true;
          settings.formatting.command = ["${pkgs.alejandra}/bin/alejandra"];
        };
        pyright.enable = true;
        ruff.enable = true;
        clangd.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
        dockerls.enable = true;
      };
    };
  };
}
