-- lua/mappings/git.lua
-- ============================================================
-- ГОРЯЧИЕ КЛАВИШИ ДЛЯ GIT
-- ============================================================
-- Все вызовы require() обёрнуты в функции для ленивой оценки.
-- Это предотвращает ошибки при загрузке до инициализации плагинов.

local map = require("core.utils").map

-- === Neogit ===
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
map("n", "<leader>gs", "<cmd>Neogit kind=split<cr>", { desc = "Neogit (split)" })
map("n", "<leader>gS", "<cmd>Neogit kind=split_above<cr>", { desc = "Neogit (split above)" })
map("n", "<leader>gt", "<cmd>Neogit kind=tab<cr>", { desc = "Neogit (tab)" })

-- === Lazygit ===
map("n", "<leader>gl", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map("n", "<leader>gL", "<cmd>LazyGitFilter<cr>", { desc = "LazyGit filter" })
map("n", "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", { desc = "LazyGit current file" })
map("n", "<leader>gF", "<cmd>LazyGitFilterCurrentFile<cr>", { desc = "LazyGit filter current file" })

-- === Diffview ===
map("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open" })
map("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Diffview close" })
map("n", "<leader>gdr", "<cmd>DiffviewRefresh<cr>", { desc = "Diffview refresh" })
map("n", "<leader>gdf", "<cmd>DiffviewToggleFiles<cr>", { desc = "Diffview toggle files" })
map("n", "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview file history" })
map("n", "<leader>gdH", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview file history (current)" })

-- === Gitsigns: Hunk-операции (обёрнуто в функции!) ===
map("n", "]h", function()
  if vim.wo.diff then return vim.cmd.normal({ "]c", bang = true }) end
  require("gitsigns").nav_hunk("next")
end, { desc = "Next hunk" })

map("n", "[h", function()
  if vim.wo.diff then return vim.cmd.normal({ "[c", bang = true }) end
  require("gitsigns").nav_hunk("prev")
end, { desc = "Previous hunk" })

map("n", "<leader>ghs", function() require("gitsigns").stage_hunk() end, { desc = "Stage hunk" })
map("n", "<leader>ghr", function() require("gitsigns").reset_hunk() end, { desc = "Reset hunk" })
map("n", "<leader>ghS", function() require("gitsigns").stage_buffer() end, { desc = "Stage buffer" })
map("n", "<leader>ghR", function() require("gitsigns").reset_buffer() end, { desc = "Reset buffer" })
map("n", "<leader>ghu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Undo stage hunk" })
map("n", "<leader>ghp", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk" })

map("v", "<leader>ghs", function()
  require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage hunk (visual)" })

map("v", "<leader>ghr", function()
  require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Reset hunk (visual)" })

-- === Gitsigns: Blame и другие ===
map("n", "<leader>gbl", function() require("gitsigns").blame_line() end, { desc = "Blame line" })
map("n", "<leader>gbL", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame line (full)" })
map("n", "<leader>gbd", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle line blame" })
map("n", "<leader>gD", function() require("gitsigns").diffthis() end, { desc = "Diff this" })
map("n", "<leader>gtd", function() require("gitsigns").toggle_deleted() end, { desc = "Toggle deleted" })
