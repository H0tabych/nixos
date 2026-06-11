-- ===== BOOTSTRAP LAZY.NVIM =====
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ===== BASIC SETTINGS =====
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
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true       -- персистентный undo
vim.opt.scrolloff = 8

-- ===== LAZY.NVIM LOCKFILE (вне /nix/store) =====
local state_dir = vim.fn.stdpath("state") .. "/nvim"
vim.fn.mkdir(state_dir, "p")

-- ===== LOAD PLUGINS (модульная структура) =====
require("lazy").setup({
  { import = "plugins.colors" },
  { import = "plugins.treesitter" },
  { import = "plugins.telescope" },
  { import = "plugins.lsp" },
  { import = "plugins.dap" },
  { import = "plugins.ui" },
  { import = "plugins.git" },
  { import = "plugins.utils" },
}, {
  lockfile = state_dir .. "/lazy-lock.json",
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  ui = { border = "rounded" },
})
