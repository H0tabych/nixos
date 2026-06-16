-- lua/keymaps/normal.lua
local M = {}

function M.setup()
  local opts = { noremap = true, silent = true }

  -- Базовые навигация и режимы
  vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
  vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
  vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
  vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

  -- Буферы
  vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", opts)

  -- Поиск
  vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
  vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", opts)

  -- Отладка
  vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, opts)
  vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, opts)
  vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end, opts)
  vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, opts)

  -- Дерево файлов
  vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", opts)
end

return M
