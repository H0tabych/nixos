-- lua/plugins/colorsheme.lua
return {
  -- 1. Цветовая схема TokyoNight (загружается первой)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night", -- "night" (стандартная тёмная) или "moon" (чуть более контрастная)
      transparent = true, -- Включаем прозрачность фона
      styles = {
        sidebars = "transparent", -- Прозрачные боковые панели (NvimTree, Telescope)
        floats = "transparent",   -- Прозрачные всплывающие окна (LSP hover, DAP)
      },
      sidebars = { "qf", "help", "NvimTree", "lazy", "Trouble" },
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = true,
      -- Интеграции с плагинами (включаются автоматически при их наличии)
      on_colors = function(colors) end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  }
}
