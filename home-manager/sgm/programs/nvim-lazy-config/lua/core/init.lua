-- lua/core/init.lua
-- ============================================================
-- ЯДРО КОНФИГУРАЦИИ
-- ============================================================
-- Загружает все модули в правильном порядке.
-- Использует pcall для безопасной загрузки — если один модуль
-- сломан, остальные продолжат работать.

local utils = require("core.utils")

-- 1. Базовые настройки Neovim (отступы, нумерация, и т.д.)
utils.safe_require("core.options")

-- 2. Глобальные горячие клавиши (без плагинов)
utils.safe_require("keymaps.normal")
utils.safe_require("keymaps.visual")

-- 3. Загрузка плагинов через lazy.nvim
-- На этом этапе директория plugins/ пуста.
-- Когда мы добавим туда файлы, lazy.nvim автоматически их подхватит.
local ok_lazy, lazy = pcall(require, "lazy")
if ok_lazy then
  lazy.setup({
    { import = "plugins" },
  }, {
    -- Файл блокировки версий храним в writable директории
    lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
    -- Не показывать уведомления об обновлениях при каждом запуске
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
    -- Красивый UI для lazy.nvim
    ui = { border = "rounded" },
    -- Цветовая схема для lazy.nvim UI (подхватит нашу тему позже)
    pkg = { enabled = true },
  })
end

-- 4. Загрузка конфигурации поведения плагинов
-- (после того, как плагины загружены)
-- utils.safe_require("config.lsp")
-- utils.safe_require("config.dap")
-- utils.safe_require("config.telescope")

-- 5. Загрузка горячих клавиш плагинов
utils.safe_require("mappings.ui")
-- utils.safe_require("mappings.lsp")
-- utils.safe_require("mappings.dap")
utils.safe_require("mappings.telescope")
utils.safe_require("mappings.git")
utils.safe_require("mappings.treesitter")
utils.safe_require("mappings.cmp")
