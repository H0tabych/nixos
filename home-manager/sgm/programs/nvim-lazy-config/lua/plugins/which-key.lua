-- lua/plugins/which-key.lua
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons",
    },
    -- ✅ Обновлённый API (без deprecated опций)
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
      -- ✅ Новый API для замены клавиш (вместо key_labels)
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
        },
      },
      -- ✅ Новый API для маппингов окна (вместо popup_mappings)
      keys = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
      },
      -- Окно
      win = {
        border = "rounded",
        no_overlap = true,
        padding = { 1, 2, 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
      },
      -- Layout
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      -- Показывать подсказки
      show_help = true,
      show_keys = true,
      -- Задержка перед показом (мс)
      delay = function(ctx)
        return 200
      end,
      -- Sort
      sort = { "local", "order", "group", "alphanum", "mod" },
      -- Expand
      expand = 0,
    },
    -- ✅ Убираем дублирование — группы определяются только в mappings/
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },
}
