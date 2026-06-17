-- lua/plugins/treesitter.lua
return {
  -- 1. Основной плагин Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
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
      -- ✅ УБИРАЕМ keymaps отсюда — они будут в mappings/treesitter.lua
      incremental_selection = {
        enable = true,
      },
    },
  },

  -- 2. Контекст (плавающий заголовок функции/класса)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = "-",
    },
  },

  -- 3. Текстовые объекты
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          -- ✅ УБИРАЕМ keymaps отсюда — они будут в mappings/treesitter.lua
        },
        move = {
          enable = true,
          set_jumps = true,
          -- ✅ УБИРАЕМ keymaps отсюда — они будут в mappings/treesitter.lua
        },
      },
    },
  },
}
