-- lua/plugins/lsp.lua
return {
  -- Менеджер серверов (для случаев, когда сервера нет в nixpkgs)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {
      ui = { border = "rounded" },
      ensure_installed = {}, -- Пустой список, так как мы используем Nix
    },
  },

  -- Интеграция Mason с LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
      })
    end,
  },

  -- LSP конфигурация через LazyVim
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "j-hui/fidget.nvim",
      { "folke/neodev.nvim", opts = {} }, -- Для Lua отладки
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Список серверов, установленных через Nix
      local servers = {
        "pyright", "nil_ls", "jsonls", "yamlls", "bashls", "sqls",
        "html", "cssls", "ts_ls", "lua_ls", "clangd", "taplo",
      }

      -- Автоматическая настройка всех серверов
      for _, server in ipairs(servers) do
        local config = {
          capabilities = capabilities,
          on_attach = require("config.lsp").on_attach,
        }

        -- Специфичные настройки
        if server == "pyright" then
          config.settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
              },
            },
          }
        elseif server == "lua_ls" then
          config.settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          }
        elseif server == "clangd" then
          config.cmd = { "clangd", "--background-index", "--clang-tidy" }
        end

        lspconfig[server].setup(config)
      end
    end,
  },
}
