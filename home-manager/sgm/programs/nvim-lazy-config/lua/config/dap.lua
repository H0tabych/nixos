local M = {}
function M.setup()
  local ok, dap = pcall(require, "dap")
  if not ok then return end

  dap.adapters.python = { type = "executable", command = "python3", args = { "-m", "debugpy.adapter" } }
  dap.configurations.python = {
    { type = "python", request = "launch", name = "Launch file", program = "${file}", pythonPath = function() return "python3" end, },
  }

  dap.adapters.lldb = { type = "executable", command = "lldb-dap", name = "lldb" }
  dap.configurations.c = {
    { name = "Launch", type = "lldb", request = "launch", program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end, cwd = "${workspaceFolder}", stopOnEntry = false, args = {}, },
  }
  dap.configurations.cpp = dap.configurations.c
  dap.configurations.rust = dap.configurations.c
end
return M
