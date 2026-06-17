-- lua/mappings/telescope.lua
-- ============================================================
-- ГОРЯЧИЕ КЛАВИШИ ДЛЯ TELESCOPE
-- ============================================================

local map = require("core.utils").map
local builtin = require("telescope.builtin")

-- === Поиск файлов ===
map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fF", function()
  builtin.find_files({ hidden = true, no_ignore = true })
end, { desc = "Find all files (including hidden)" })

-- === Поиск текста ===
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fG", function()
  builtin.live_grep({ additional_args = { "--hidden" } })
end, { desc = "Live grep (including hidden)" })
map("n", "<leader>fw", builtin.grep_string, { desc = "Grep word under cursor" })

-- === Буферы ===
map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })

-- === Недавние файлы ===
map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })

-- === Помощь и документация ===
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>fm", builtin.man_pages, { desc = "Man pages" })

-- === LSP (будет работать после добавления LSP) ===
map("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
map("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>fi", builtin.lsp_implementations, { desc = "LSP implementations" })
map("n", "<leader>fD", builtin.lsp_definitions, { desc = "LSP definitions" })
map("n", "<leader>fR", builtin.lsp_references, { desc = "LSP references" })

-- === Git ===
map("n", "<leader>fgc", builtin.git_commits, { desc = "Git commits" })
map("n", "<leader>fgC", builtin.git_bcommits, { desc = "Git buffer commits" })
map("n", "<leader>fgb", builtin.git_branches, { desc = "Git branches" })
map("n", "<leader>fgs", builtin.git_status, { desc = "Git status" })
map("n", "<leader>fgS", builtin.git_stash, { desc = "Git stash" })

-- === Treesitter ===
map("n", "<leader>ft", builtin.treesitter, { desc = "Treesitter symbols" })

-- === Системные ===
map("n", "<leader>f:", builtin.command_history, { desc = "Command history" })
map("n", "<leader>f/", builtin.search_history, { desc = "Search history" })
map("n", "<leader>fq", builtin.quickfix, { desc = "Quickfix list" })
map("n", "<leader>fQ", builtin.loclist, { desc = "Location list" })
map("n", "<leader>fj", builtin.jumplist, { desc = "Jumplist" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
