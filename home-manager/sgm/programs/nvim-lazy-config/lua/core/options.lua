-- lua/core/options.lua
-- ============================================================
-- БАЗОВЫЕ НАСТРОЙКИ NEOVIM
-- ============================================================
-- Эти настройки не зависят от плагинов и работают везде.
-- Переносимы между дистрибутивами.

-- === Лидер-клавиша ===
-- Должна быть установлена ДО загрузки плагинов, чтобы они могли
-- использовать её в своих маппингах
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- === Отключение совместимости с Vi ===
vim.o.compatible = false

-- === UI ===
vim.o.number = true                 -- Номера строк
vim.o.relativenumber = true         -- Относительные номера
vim.o.signcolumn = "yes"            -- Всегда показывать колонку знаков
vim.o.cursorline = true             -- Подсветка текущей строки
vim.o.cursorlineopt = "number"      -- Подсветка только номера
vim.o.termguicolors = true          -- 24-бит цвета
vim.o.pumheight = 10                -- Высота popup menu
vim.o.showmode = false              -- Не показывать режим (lualine покажет)
vim.o.cmdheight = 1                 -- Высота командной строки
vim.o.scrolloff = 8                 -- Отступ при скролле
vim.o.sidescrolloff = 8
vim.o.splitbelow = true             -- Новые сплиты снизу
vim.o.splitright = true             -- Новые сплиты справа
vim.o.wrap = false                  -- Не переносить строки
vim.o.linebreak = true              -- Но переносить по словам (если wrap=true)
vim.o.conceallevel = 0              -- Показывать всё явно
vim.o.signcolumn = "yes"            -- Всегда показывать signcolumn
vim.o.laststatus = 3                -- Глобальный статус-бар (для lualine)
vim.o.showtabline = 1               -- Показывать табы только если >1

-- === Поиск ===
vim.o.hlsearch = true               -- Подсвечивать результаты поиска
vim.o.incsearch = true              -- Искать по мере ввода
vim.o.ignorecase = true             -- Игнорировать регистр...
vim.o.smartcase = true              -- ...если нет заглавных букв

-- === Отступы и табуляция ===
vim.o.tabstop = 4                   -- Таб = 4 пробела
vim.o.shiftwidth = 4                -- Отступ при >> и <<
vim.o.expandtab = true              -- Табы → пробелы
vim.o.smartindent = true            -- Умные отступы
vim.o.autoindent = true             -- Наследовать отступ от предыдущей строки
vim.o.breakindent = true            -- Сохранять отступ при переносе

-- === История и отмена ===
vim.o.history = 10000               -- Размер истории команд
vim.o.undofile = true               -- Сохранять undo между сессиями
vim.o.undolevels = 10000            -- Глубина undo
vim.o.updatetime = 250              -- Быстрее обновлять (для CursorHold)
vim.o.timeoutlen = 300              -- Время ожидания комбинаций клавиш

-- === Буфер обмена (Wayland + X11) ===
-- "unnamedplus" — использовать системный буфер обмена (+ регистр)
-- В Wayland это работает через wl-copy/wl-paste (из wl-clipboard)
-- В X11 — через xclip/xsel
vim.o.clipboard = "unnamedplus"

-- === Производительность ===
vim.o.lazyredraw = false            -- Не отключать redraw (современные терминалы быстрые)
vim.o.synmaxcol = 240               -- Ограничить подсветку синтаксиса по длине строки
vim.o.ttyfast = true                -- Оптимизация для быстрых терминалов

-- === Файлы и бэкапы ===
vim.o.backup = false                -- Не создавать бэкапы
vim.o.writebackup = false           -- Не создавать бэкапы при записи
vim.o.swapfile = false              -- Не создавать swap-файлы
vim.o.autoread = true               -- Автоматически перечитывать изменённые файлы

-- === Автокоманды ===
-- Подсветка при yank (копировании)
local yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Автоматически возвращаться к последней позиции в файле
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Убирать trailing whitespace при сохранении (опционально)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   command = "%s/\\s\\+$//e",
-- })

-- Закрытие некоторых окон по q
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf", "help", "man", "notify", "lspinfo",
    "PlenaryTestPopup", "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
    })
  end,
})

-- Автоматически открывать help в вертикальном сплите
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})
