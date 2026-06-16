-- lua/mappings/treesitter.lua
local M = {}

function M.setup()
  local opts = { noremap = true, silent = true }

  -- Incremental selection уже настроен в plugins/treesitter.lua
  -- Здесь можно добавить дополнительные привязки если нужно

  -- Пример: переключение подсветки
  vim.keymap.set("n", "<leader>ts", function()
    local status = vim.g.ts_highlight
    if status == nil or status == true then
      vim.g.ts_highlight = false
      vim.cmd("TSBufDisable highlight")
      vim.notify("Treesitter highlight disabled", vim.log.levels.INFO)
    else
      vim.g.ts_highlight = true
      vim.cmd("TSBufEnable highlight")
      vim.notify("Treesitter highlight enabled", vim.log.levels.INFO)
    end
  end, vim.tbl_extend("force", opts, { desc = "Toggle Treesitter Highlight" }))
end

return M
