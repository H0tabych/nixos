return {
  -- 1. Менеджер плагинов
  { "folke/lazy.nvim", version = false },

  -- 2. Цветовая схема
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = true },

  -- 3. Treesitter (используем opts вместо config для надежности)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" }, -- Загружать при открытии файла
    opts = {
      ensure_installed = { "lua", "python", "cpp", "nix", "markdown", "sql", "json", "bash" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- 4. Telescope (поиск)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          mappings = {
            i = { ["<C-u>"] = false, ["<C-d>"] = false },
          },
        },
      })
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Live Grep' })
    end,
  },

  -- 5. Autocompletion (LSP)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  
  -- 6. LSP Config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Базовая настройка: прикрепить LSP к буферу при открытии файла
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        end,
      })
      
      -- Пример: раскомментируйте и установите серверы через Nix (см. ниже), чтобы они работали
      -- require('lspconfig').pyright.setup{}
      -- require('lspconfig').clangd.setup{}
    end,
  },
}
