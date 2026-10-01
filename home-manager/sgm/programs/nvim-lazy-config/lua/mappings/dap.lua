local M = {}
function M.setup()
  local ok, dap = pcall(require, "dap")
  if not ok then return end
  local map = vim.keymap.set
  map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
  map("n", "<leader>dc", dap.continue, { desc = "Continue" })
  map("n", "<leader>dso", dap.step_over, { desc = "Step Over" })
  map("n", "<leader>dsi", dap.step_into, { desc = "Step Into" })
  map("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
end
return M
