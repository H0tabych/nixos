-- lua/plugins/which-key.lua
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons",
    },
    opts = {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘴 ",
          S = "󰘴 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
        },
      },
      keys = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
      },
      win = {
        border = "rounded",
        no_overlap = true,
        padding = { 1, 2, 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      show_help = true,
      show_keys = true,
      delay = function(ctx)
        return 200
      end,
      sort = { "local", "order", "group", "alphanum", "mod" },
      expand = 0,
      spec = {
          { "<leader>e", group = "Explorer" },
          { "<leader>f", group = "Find" },
          { "<leader>g", group = "Git" },
          { "<leader>gh", group = "Hunks" },
          { "<leader>gd", group = "Diffview" },
          { "<leader>gb", group = "Blame" },
          { "<leader>x", group = "Diagnostics/Todo" },
          { "<leader>b", group = "Buffer" },
          { "<leader>w", group = "Window" },
          { "<leader>T", group = "Terminal" },
          { "<leader>c", group = "Config" },
          { "<C-Space>", desc = "Trigger completion" },
        },
    },
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },
}
