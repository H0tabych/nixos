-- lua/core/options.lua
-- Базовые настройки Neovim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.clipboard = "unnamedplus"

-- Настройки для Lazy.nvim
local state_dir = vim.fn.stdpath("state") .. "/nvim"
vim.fn.mkdir(state_dir, "p")
require("lazy").setup({
  defaults = {
    lockfile = state_dir .. "/lazy-lock.json",
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
  },
})
