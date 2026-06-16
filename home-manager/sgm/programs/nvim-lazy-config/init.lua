-- ~/.config/nvim/init.lua
-- Установка пути к конфигурации
vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lazy-config")

-- Загрузка ядра LazyVim
require("core.init")
