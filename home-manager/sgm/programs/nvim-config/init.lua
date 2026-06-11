-- ===== 1. BOOTSTRAP LAZY.NVIM =====
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ===== 2. BASIC NEOVIM SETTINGS =====
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

-- ===== 3. FIX FOR NIXOS: Переносим lazy-lock.json в writable директорию =====
local state_dir = vim.fn.stdpath("state") .. "/nvim"
vim.fn.mkdir(state_dir, "p") -- Создаем директорию, если её нет

-- ===== 4. LOAD PLUGINS =====
require("lazy").setup("plugins", {
  -- КРИТИЧЕСКИ ВАЖНО для NixOS: указываем путь к lockfile вне /nix/store
  lockfile = state_dir .. "/lazy-lock.json",
  
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})
