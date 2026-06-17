-- lua/plugins/treesitter.lua
return {
  -- 1. Основной плагин Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Автоматически обновляет парсеры при изменении плагина
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    -- ✅ СОВРЕМЕННЫЙ API: используем opts вместо config
    opts = {
      ensure_installed = {
        "c", "cpp", "python", "lua", "nix",
        "markdown", "markdown_inline", "sql",
        "json", "yaml", "toml", "bash",
        "html", "css", "javascript", "typescript",
        "dockerfile", "xml", "vim", "vimdoc"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          node_decremental = "<bs>",
        },
      },
    },
  },

  -- 2. Контекст (плавающий заголовок функции/класса вверху экрана)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable = true,
      max_lines = 3, -- Показывать не более 3 строк контекста
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = "-",
    },
  },

  -- 3. Текстовые объекты (выделение функций, классов и т.д.)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    -- ✅ СОВРЕМЕННЫЙ API: передаём настройки через opts
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    },
  },
}
