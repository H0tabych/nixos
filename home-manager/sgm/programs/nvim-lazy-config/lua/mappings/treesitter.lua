-- lua/mappings/treesitter.lua
-- ============================================================
-- ГОРЯЧИЕ КЛАВИШИ ДЛЯ TREESITTER
-- ============================================================

local map = require("core.utils").map

-- === Incremental Selection (расширение/сужение выделения) ===
map("n", "<C-space>", function()
  require("nvim-treesitter.incremental_selection").node_incremental()
end, { desc = "Incremental selection" })

map("x", "<C-space>", function()
  require("nvim-treesitter.incremental_selection").node_incremental()
end, { desc = "Incremental selection" })

map("x", "<bs>", function()
  require("nvim-treesitter.incremental_selection").node_decremental()
end, { desc = "Decremental selection" })

-- === Text Objects (выделение функций, классов) ===
-- Эти клавиши работают в visual и operator-pending режимах
-- af/if — функция (outer/inner)
-- ac/ic — класс (outer/inner)

-- === Navigation (перемещение между функциями/классами) ===
map("n", "]m", function()
  require("nvim-treesitter.textobjects.move").goto_next_start("@function.outer")
end, { desc = "Next function start" })

map("n", "]M", function()
  require("nvim-treesitter.textobjects.move").goto_next_end("@function.outer")
end, { desc = "Next function end" })

map("n", "[m", function()
  require("nvim-treesitter.textobjects.move").goto_previous_start("@function.outer")
end, { desc = "Previous function start" })

map("n", "[M", function()
  require("nvim-treesitter.textobjects.move").goto_previous_end("@function.outer")
end, { desc = "Previous function end" })

map("n", "]]", function()
  require("nvim-treesitter.textobjects.move").goto_next_start("@class.outer")
end, { desc = "Next class start" })

map("n", "][", function()
  require("nvim-treesitter.textobjects.move").goto_next_end("@class.outer")
end, { desc = "Next class end" })

map("n", "[[", function()
  require("nvim-treesitter.textobjects.move").goto_previous_start("@class.outer")
end, { desc = "Previous class start" })

map("n", "[]", function()
  require("nvim-treesitter.textobjects.move").goto_previous_end("@class.outer")
end, { desc = "Previous class end" })
