# ~/nixos-config/home-manager/sgm/programs/neovim/core/options.nix
{ ... }:
{
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  opts = {
    number = true;
    relativenumber = true;
    tabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    mouse = "a";
    clipboard = "unnamedplus";
    undofile = true;
    ignorecase = true;
    smartcase = true;
    cursorline = true;
    scrolloff = 8;
    sidescrolloff = 8;
    splitbelow = true;
    splitright = true;
  };
}
