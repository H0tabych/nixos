-- lua/keymaps/visual.lua
-- ============================================================
-- ГЛОБАЛЬНЫЕ ПРИВЯЗКИ VISUAL MODE
-- ============================================================

local map = require("core.utils").map

-- === Улучшенная работа с отступами ===
-- После сдвига выделение сохраняется
map("v", "<", "<gv", { desc = "Unindent and keep selection" })
map("v", ">", ">gv", { desc = "Indent and keep selection" })

-- === Перемещение выделенного блока ===
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- === Буфер обмена ===
-- Копирование в системный буфер обмена
map("v", "<leader>y", '"+y', { desc = "Yank selection to clipboard" })
map("v", "<leader>Y", '"+ygy', { desc = "Yank selection to clipboard (line)" })

-- Вставка из системного буфера обмена без замены буфера
map("v", "<leader>p", '"_d"+p', { desc = "Paste from clipboard (replace)" })

-- === Сохранение выделенного текста в файл ===
map("v", "<leader>w", function()
  vim.cmd("write")
end, { desc = "Save selection" })

-- === Поиск в выделенном тексте ===
map("v", "//", 'y/<C-R>"<CR>', { desc = "Search for selection" })

-- === Отмена стандартных привязок ===
-- Запрещаем запись через Q (ex mode) — он редко нужен
map("n", "Q", "<Nop>", { desc = "Disable Ex mode" })
