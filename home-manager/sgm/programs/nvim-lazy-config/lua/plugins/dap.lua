-- lua/plugins/dap.lua
return {
  -- Ядро отладки
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
  },

  -- UI для отладки
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("config.dap").setup_ui()
    end,
  },

  -- Виртуальный текст для переменных
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      enabled = true,
      highlight_changed_variables = true,
      comment_static = true,
    },
  },

  -- Интеграция с Mason (отключена для NixOS)
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      automatic_installation = false, -- Используем Nix
      handlers = {},
    },
  },
}
