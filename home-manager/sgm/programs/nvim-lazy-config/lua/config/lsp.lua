-- lua/config/lsp.lua
local M = {}

function M.on_attach(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- Горячие клавиши (будут переопределены в mappings/lsp.lua)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  map("n", "gD", vim.lsp.buf.type_definition, "Go to Type Definition")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "gi", vim.lsp.buf.implementation, "Implementation")
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
  map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
  map("n", "<leader>e", vim.diagnostic.open_float, "Show Diagnostic")
  map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostic List")
end

return M
