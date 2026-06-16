-- lua/plugins/ui.lua
return {
  -- 1. Иконки (ОБЯЗАТЕЛЬНО оба пакета для which-key)
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "echasnovski/mini.icons", lazy = true }, -- ✅ ДОБАВЛЕНО: требуется для which-key

  -- 2. Цветовая схема (ПЕРВЫЙ плагин)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
          telescope = true,
          nvimtree = true,
          mason = true,
          dap = { enabled = true, enable_ui = true },
          lualine = true,
          which_key = true,
          indent_blankline = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- 3. Дерево файлов
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus" },
    keys = {
      { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Tree" },
      { "<leader>T", "<cmd>NvimTreeFocus<cr>", desc = "Focus Tree" },
    },
    opts = {
      sort_by = "case_sensitive",
      view = { width = 30, side = "left" },
      renderer = {
        group_empty = true,
        icons = { show = { git = true, folder = true, file = true } },
      },
      filters = { dotfiles = false },
      git = { enable = true },
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
    },
  },

  -- 4. Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "catppuccin/nvim",
    },
    event = "VeryLazy",
    config = function()
      -- Гарантируем, что catppuccin загружен
      local ok, catppuccin = pcall(require, "catppuccin")
      if ok then
        catppuccin.setup({
          flavour = "mocha",
          integrations = { lualine = true },
        })
      end

      -- Загружаем lualine
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = {
            statusline = { "NvimTree", "lazy", "dap-repl", "dapui_" },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- 5. Buffer line (табы)
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_buffer_close_icons = true,
        show_close_icon = false,
      },
    },
  },

  -- 6. Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      indent = { char = "│", tab_char = "│" },
      whitespace = { remove_blankline_trail = true },
      scope = { enabled = true, show_start = false, show_end = false },
    },
  },

  -- 7. Which-key (с mini.icons!)
  {
    "folke/which-key.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons", -- ✅ КРИТИЧЕСКИ ВАЖНО для which-key
    },
    event = "VeryLazy",
    opts = {
      icons = { mappings = false },
      spec = {
        { "<leader>l", group = "LSP" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>t", group = "Tree" },
        { "<leader>x", group = "Diagnostics" },
      },
    },
  },

  -- 8. Comment
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      toggler = { line = "gcc", block = "gbc" },
      opleader = { line = "gc", block = "gb" },
    },
  },

  -- 9. Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
      },
    },
    config = function(_, opts)
      local autopairs = require("nvim-autopairs")
      autopairs.setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- 10. Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, "Blame")
      end,
    },
  },

  -- 11. Trouble
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Loclist" },
    },
    opts = { use_diagnostic_signs = true },
  },
}
