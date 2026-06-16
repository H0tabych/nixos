-- lua/core/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Подключение глобальных опций
require("core.options")

-- Загрузка плагинов по категориям
require("plugins.lsp")
--require("plugins.dap")
--require("plugins.telescope")
--require("plugins.treesitter")
--require("plugins.ui")

-- Загрузка конфигурации поведения
require("config.lsp")
--require("config.dap")
--require("config.telescope")

-- Загрузка горячих клавиш
require("mappings.lsp")
--require("mappings.dap")
--require("mappings.telescope")
--require("mappings.treesitter")

-- Загрузка глобальных привязок
require("keymaps.normal")
--require("keymaps.visual")
