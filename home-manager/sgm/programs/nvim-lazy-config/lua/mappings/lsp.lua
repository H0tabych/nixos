-- lua/mappings/lsp.lua
-- ============================================================
-- ГОРЯЧИЕ КЛАВИШИ LSP
-- ============================================================
-- Эти хоткеи регистрируются для каждого буфера, к которому подключён LSP.
-- Они НЕ дублируют хоткеи из keymaps/normal.lua (там уже есть [d, ]d, <leader>e, <leader>q).

local M = {}

function M.setup(bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = desc,
    })
  end

  -- === Навигация ===
  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gr", vim.lsp.buf.references, "Go to references")
  map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")

  -- === Документация ===
  map("n", "K", vim.lsp.buf.hover, "Show hover documentation")
  map("n", "<C-k>", vim.lsp.buf.signature_help, "Show signature help")

  -- === Действия ===
  map("n", "<leader>lr", vim.lsp.buf.rename, "Rename symbol")
  map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, "Format buffer")

  -- === Workspace ===
  map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  map("n", "<leader>lwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
end

return M
