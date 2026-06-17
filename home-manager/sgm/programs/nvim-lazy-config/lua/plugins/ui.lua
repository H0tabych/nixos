-- lua/plugins/ui.lua
return {
  -- Иконки
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "echasnovski/mini.icons", lazy = true },

  -- Дерево файлов
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- ✅ Только cmd для ленивой загрузки. Хоткеи — в mappings/ui.lua
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = { enable = true, update_root = true },
        view = { width = 35, side = "left" },
        renderer = {
          group_empty = true,
          indent_markers = { enable = true },
          icons = {
            show = { git = true, folder = true, file = true, folder_arrow = true },
            glyphs = {
              git = {
                unstaged = "✗", staged = "✓", unmerged = "",
                renamed = "➜", untracked = "★", deleted = "", ignored = "◌",
              },
            },
          },
        },
        filters = { dotfiles = false },
        git = { enable = true, timeout = 400 },
        diagnostics = {
          enable = true,
          icons = { hint = "", info = "", warning = "", error = "" },
        },
      })
    end,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      toggler = { line = "gcc", block = "gbc" },
      opleader = { line = "gc", block = "gb" },
    },
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Gitsigns (инлайн-изменения в gutter)
  -- ✅ УБРАН on_attach — все хоткеи теперь в mappings/git.lua
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = false, -- Включаем по хоткею, не постоянно
    },
  },

  -- Trouble (красивый список ошибок)
  -- ✅ УБРАНЫ keys — все хоткеи в mappings/ui.lua
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    cmd = { "Trouble" },
    opts = { use_diagnostic_signs = true },
  },

  -- Todo-comments (бонус: подсветка TODO, FIXME, HACK в коде)
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
  },
}
