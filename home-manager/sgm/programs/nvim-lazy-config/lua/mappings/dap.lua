-- lua/mappings/dap.lua
local M = {}

function M.setup()
  local opts = { noremap = true, silent = true }

  -- Основные команды отладки
  vim.keymap.set("n", "<leader>db", function()
    require("dap").toggle_breakpoint()
  end, vim.tbl_extend("force", opts, { desc = "Toggle Breakpoint" }))

  vim.keymap.set("n", "<leader>dB", function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, vim.tbl_extend("force", opts, { desc = "Conditional Breakpoint" }))

  vim.keymap.set("n", "<leader>dc", function()
    require("dap").continue()
  end, vim.tbl_extend("force", opts, { desc = "Continue" }))

  vim.keymap.set("n", "<leader>do", function()
    require("dap").step_over()
  end, vim.tbl_extend("force", opts, { desc = "Step Over" }))

  vim.keymap.set("n", "<leader>di", function()
    require("dap").step_into()
  end, vim.tbl_extend("force", opts, { desc = "Step Into" }))

  vim.keymap.set("n", "<leader>dO", function()
    require("dap").step_out()
  end, vim.tbl_extend("force", opts, { desc = "Step Out" }))

  vim.keymap.set("n", "<leader>dr", function()
    require("dap").repl.open()
  end, vim.tbl_extend("force", opts, { desc = "Open REPL" }))

  vim.keymap.set("n", "<leader>dl", function()
    require("dap").run_last()
  end, vim.tbl_extend("force", opts, { desc = "Run Last" }))

  -- UI команды
  vim.keymap.set("n", "<leader>du", function()
    require("dapui").toggle()
  end, vim.tbl_extend("force", opts, { desc = "Toggle DAP UI" }))

  vim.keymap.set({ "n", "v" }, "<leader>de", function()
    require("dapui").eval()
  end, vim.tbl_extend("force", opts, { desc = "Eval under cursor" }))
end

return M
