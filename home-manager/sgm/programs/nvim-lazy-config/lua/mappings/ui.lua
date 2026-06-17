-- lua/mappings/ui.lua
-- ============================================================
-- ГОРЯЧИЕ КЛАВИШИ ДЛЯ UI-ПЛАГИНОВ
-- ============================================================

local map = require("core.utils").map

-- === NvimTree ===
map("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Find file in tree" })
map("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh file tree" })

-- === Comment.nvim ===
-- Эти хоткеи уже определены в самом плагине через opts,
-- но мы можем добавить дополнительные
-- gcc — закомментировать строку (уже есть)
-- gbc — закомментировать блок (уже есть)
-- gc — закомментировать в visual mode (уже есть)

-- === Trouble (диагностика) ===
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Loclist" })
