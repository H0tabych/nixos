# ~/nixos-config/home-manager/sgm/programs/neovim/modules/formatting.nix
{ ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      formatters_by_ft = {
        nix = [ "alejandra" ];
        python = [ "ruff" ];
        cpp = [ "clang_format" ];
        rust = [ "rustfmt" ];
        lua = [ "stylua" ];
        html = [ "prettier" ];
        css = [ "prettier" ];
        json = [ "prettier" ];
        yaml = [ "prettier" ];
        markdown = [ "prettier" ];
      };
    };
  };
}
