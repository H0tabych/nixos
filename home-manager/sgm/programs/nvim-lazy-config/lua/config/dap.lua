-- lua/config/dap.lua
local M = {}

function M.setup_ui()
  local dap = require("dap")
  local dapui = require("dapui")

  -- Автоматически открывать/закрывать UI
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  -- Настройка UI
  dapui.setup({
    icons = {
      expanded = "▾",
      collapsed = "▸",
      current_frame = "▸",
    },
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        size = 40,
        position = "left",
      },
      {
        elements = {
          { id = "repl", size = 0.5 },
          { id = "console", size = 0.5 },
        },
        size = 10,
        position = "bottom",
      },
    },
  })

  -- Знаки для breakpoint'ов
  vim.fn.sign_define("DapBreakpoint", {
    text = "🔴",
    texthl = "DapBreakpoint",
    linehl = "",
    numhl = "",
  })
  vim.fn.sign_define("DapBreakpointCondition", {
    text = "🟡",
    texthl = "DapBreakpointCondition",
    linehl = "",
    numhl = "",
  })
  vim.fn.sign_define("DapStopped", {
    text = "▶️",
    texthl = "DapStopped",
    linehl = "Visual",
    numhl = "DapStopped",
  })

  -- Конфигурации для Python
  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      pythonPath = function()
        return vim.fn.exepath("python3")
      end,
    },
  }

  -- Конфигурации для C/C++
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    },
  }

  dap.configurations.c = dap.configurations.cpp
end

return M
