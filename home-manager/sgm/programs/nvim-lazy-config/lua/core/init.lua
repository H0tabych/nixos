-- lua/core/init.lua

-- 1. Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Подключение глобальных опций
require("core.options")

-- 3. Загрузка плагинов через Lazy.nvim
-- ПРАВИЛЬНЫЙ СИНТАКСИС: первый аргумент - список плагинов, второй - опции
require("lazy").setup({
  -- Список плагинов (импорты из директории plugins/)
  { import = "plugins" },
}, {
  -- Опции Lazy.nvim (второй аргумент)
  defaults = {
    lazy = false, -- все плагины НЕ ленивые по умолчанию
  },
  -- ✅ ИСПРАВЛЕННЫЙ путь (без дублирования nvim)
  lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  ui = {
    border = "rounded",
  },
})

-- 4. Загрузка конфигурации поведения
pcall(require, "config.lsp")
pcall(require, "config.dap")
pcall(require, "config.telescope")

-- 5. Загрузка горячих клавиш
pcall(require, "mappings.lsp")
pcall(require, "mappings.dap")
pcall(require, "mappings.telescope")
pcall(require, "mappings.treesitter")

-- 6. Загрузка глобальных привязок
pcall(require, "keymaps.normal")
pcall(require, "keymaps.visual")
