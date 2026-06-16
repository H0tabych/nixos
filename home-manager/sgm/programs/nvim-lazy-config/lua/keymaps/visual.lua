-- lua/keymaps/visual.lua
local M = {}

function M.setup()
  local opts = { noremap = true, silent = true }

  -- Улучшенная навигация в Visual режиме
  vim.keymap.set("v", "<", "<gv", opts)
  vim.keymap.set("v", ">", ">gv", opts)

  -- Перемещение выделенного текста вверх/вниз
  vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
  vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

  -- Копирование в системный буфер обмена
  vim.keymap.set("v", "<leader>y", '"+y', vim.tbl_extend("force", opts, { desc = "Copy to clipboard" }))

  -- Вставка из системного буфера обмена
  vim.keymap.set("v", "<leader>p", '"+p', vim.tbl_extend("force", opts, { desc = "Paste from clipboard" }))

  -- Eval в отладчике
  vim.keymap.set("v", "<leader>de", function()
    require("dapui").eval()
  end, vim.tbl_extend("force", opts, { desc = "Eval selection" }))
end

return M
