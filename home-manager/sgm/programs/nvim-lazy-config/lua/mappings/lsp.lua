-- lua/mappings/lsp.lua
local M = {}

function M.setup()
  local opts = { noremap = true, silent = true }

  -- Глобальные команды
  vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>li", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>lc", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)

  -- Диагностики
  vim.keymap.set("n", "<leader>le", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>lq", function() vim.diagnostic.setloclist() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
end

return M
