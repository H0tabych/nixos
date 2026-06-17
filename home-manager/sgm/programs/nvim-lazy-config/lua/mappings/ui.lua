-- lua/mappings/ui.lua
-- ============================================================
-- ГОРЯЧИЕ КЛАВИШИ ДЛЯ UI-ПЛАГИНОВ
-- ============================================================

local map = require("core.utils").map

-- === NvimTree ===
map("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Find file in tree" })
map("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh file tree" })
map("n", "<leader>eF", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file tree" })

-- === Trouble (диагностика) ===
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Loclist" })
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.severity=4<cr>", { desc = "Warnings only" })
map("n", "<leader>xe", "<cmd>Trouble diagnostics toggle filter.severity=1<cr>", { desc = "Errors only" })

-- === Todo-comments ===
map("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todos" })
map("n", "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", { desc = "Todos/Fixes" })
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo" })
