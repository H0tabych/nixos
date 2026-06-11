return {
  -- 1. Ядро отладки (DAP)
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      
      -- Красивые иконки для брейкпоинтов
      vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DapStopped", linehl = "Visual", numhl = "DapStopped" })

      -- === БАЗОВЫЕ КОНФИГУРАЦИИ ОТЛАДЧИКОВ (используют пакеты из Nix) ===
      
      -- Python (debugpy)
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

      -- C/C++ (lldb)
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
    end,
  },

  -- 2. КРИТИЧЕСКАЯ ЗАВИСИМОСТЬ (должна быть загружена ДО dap-ui)
  { "nvim-neotest/nvim-nio", lazy = true },

  -- 3. Графический интерфейс отладки (DAP UI)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { 
      "mfussenegger/nvim-dap", 
      "nvim-neotest/nvim-nio" -- Явное указание зависимости
    },
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval under cursor" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Автоматически открывать/закрывать UI при начале/конце отладки
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        layouts = {
          { elements = { "scopes", "breakpoints", "stacks", "watches" }, size = 40, position = "left" },
          { elements = { "repl", "console" }, size = 10, position = "bottom" },
        },
      })
    end,
  },

  -- 4. Виртуальный текст (значения переменных прямо в коде при пошаговой отладке)
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    opts = {
      enabled = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
    },
  },

  -- 5. Отключаем попытки Mason устанавливать отладчики (мы используем Nix)
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
    opts = {
      automatic_installation = false, -- Не скачивать ничего
      handlers = {},
    },
  },
}
