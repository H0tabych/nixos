# ~/nixos-config/home-manager/sgm/programs/neovim/modules/editor.nix
{ pkgs, ... }:
{
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        python cpp c rust html css json yaml dockerfile sql bash regex markdown nix
      ];
    };

    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        signs = {
          add = { text = "│"; };
          change = { text = "│"; };
          delete = { text = "_"; };
          topdelete = { text = "‾"; };
          changedelete = { text = "~"; };
        };
      };
    };

    mini = {
      enable = true;
      modules = {
        comment = {};
        surround = {};
        statusline = {};
      };
    };
  };
}
