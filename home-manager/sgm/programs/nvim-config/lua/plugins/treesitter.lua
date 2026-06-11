return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    -- Используем opts: lazy.nvim сам вызовет правильный setup
    opts = {
      ensure_installed = {
        "lua", "python", "cpp", "c", "nix",
        "markdown", "markdown_inline", "sql",
        "json", "yaml", "toml", "bash", "html", "css",
      },
      highlight = { enable = true },
      indent = { enable = true },
      -- incremental_selection больше не требует отдельного require("configs")
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
  
  -- ⚠️ ВРЕМЕННО ОТКЛЮЧЕНО:
  -- nvim-treesitter-textobjects сейчас ломается из-за удаления 
  -- require("nvim-treesitter.configs") в master-ветке основного плагина.
  -- Как только плагин обновится, его можно будет вернуть.
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   event = "VeryLazy",
  --   opts = { ... }
  -- }
}
