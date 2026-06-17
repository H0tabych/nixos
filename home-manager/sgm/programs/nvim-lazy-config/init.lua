-- ~/.config/nvim/init.lua
-- ============================================================
-- ТОЧКА ВХОДА КОНФИГУРАЦИИ NEOVIM
-- ============================================================
-- Этот файл должен быть максимально минималистичным.
-- Его задача: загрузить lazy.nvim и передать управление ядру.

-- 1. Bootstrap lazy.nvim (менеджер плагинов)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 2. Передаём управление ядру конфигурации
require("core.init")
