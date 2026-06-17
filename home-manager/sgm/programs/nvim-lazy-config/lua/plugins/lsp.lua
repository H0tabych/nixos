-- lua/plugins/lsp.lua
-- ============================================================
-- СПЕЦИФИКАЦИИ LSP-ПЛАГИНОВ
-- ============================================================

return {
  -- 1. Neodev — добавляет типы Neovim API в lua-language-server
  {
    "folke/neodev.nvim",
    ft = "lua", -- Загружается только для Lua файлов
    opts = {
      runtime = true, -- Добавляет типы Neovim runtime
      lspconfig = true, -- Автоматически настраивает lua-language-server
      pathStrict = true, -- Строгая проверка путей
    },
  },

  -- 2. nvim-lspconfig — конфигурация LSP-серверов
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Для интеграции с cmp
      "folke/neodev.nvim",
    },
    config = function()
      -- Загружаем конфигурацию из config/lsp.lua
      require("config.lsp").setup()
    end,
  },

  -- 3. none-ls.nvim — форматтеры и линтеры (форк null-ls)
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- === Nix ===
          null_ls.builtins.formatting.nixfmt,
          null_ls.builtins.diagnostics.statix,

          -- === Lua ===
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.selene.with({
            condition = function(utils)
              return utils.root_has_file("selene.toml")
            end,
          }),

          -- === Vim ===
          null_ls.builtins.diagnostics.vint,
        },

        -- Обновлять при сохранении
        update_in_insert = false,
      })
    end,
  },
}
