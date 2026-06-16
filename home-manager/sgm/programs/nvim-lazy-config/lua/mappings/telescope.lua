-- lua/mappings/telescope.lua
local M = {}

function M.setup()
  local opts = { noremap = true, silent = true }

  -- Поиск файлов
  vim.keymap.set("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
  end, vim.tbl_extend("force", opts, { desc = "Find Files" }))

  -- Поиск текста
  vim.keymap.set("n", "<leader>fg", function()
    require("telescope.builtin").live_grep()
  end, vim.tbl_extend("force", opts, { desc = "Live Grep" }))

  -- Буферы
  vim.keymap.set("n", "<leader>fb", function()
    require("telescope.builtin").buffers()
  end, vim.tbl_extend("force", opts, { desc = "Find Buffers" }))

  -- Помощь
  vim.keymap.set("n", "<leader>fh", function()
    require("telescope.builtin").help_tags()
  end, vim.tbl_extend("force", opts, { desc = "Help Tags" }))

  -- Недавние файлы
  vim.keymap.set("n", "<leader>fr", function()
    require("telescope.builtin").oldfiles()
  end, vim.tbl_extend("force", opts, { desc = "Recent Files" }))

  -- Диагностики
  vim.keymap.set("n", "<leader>fd", function()
    require("telescope.builtin").diagnostics()
  end, vim.tbl_extend("force", opts, { desc = "Diagnostics" }))

  -- Символы документа
  vim.keymap.set("n", "<leader>fs", function()
    require("telescope.builtin").lsp_document_symbols()
  end, vim.tbl_extend("force", opts, { desc = "Document Symbols" }))

  -- Символы рабочего пространства
  vim.keymap.set("n", "<leader>fS", function()
    require("telescope.builtin").lsp_workspace_symbols()
  end, vim.tbl_extend("force", opts, { desc = "Workspace Symbols" }))
end

return M
