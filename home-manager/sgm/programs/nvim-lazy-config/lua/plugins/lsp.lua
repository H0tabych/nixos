-- lua/plugins/lsp.lua
return {
  -- 1. Mason (резервный механизм для серверов, которых нет в nixpkgs)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {
      ui = { border = "rounded" },
      ensure_installed = {}, -- Пустой список, так как мы используем Nix
    },
  },

  -- 2. Интеграция Mason с LSP
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

  -- 3. LSP конфигурация через НОВЫЙ API Neovim 0.11+
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "j-hui/fidget.nvim",
      { "folke/neodev.nvim", opts = {} },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ✅ НОВЫЙ API: vim.lsp.config() вместо lspconfig[server].setup()
      
      -- Настройки по умолчанию для всех серверов
      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, noremap = true, silent = true }
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
          end

          -- Горячие клавиши LSP
          map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
          map("n", "gD", vim.lsp.buf.type_definition, "Go to Type Definition")
          map("n", "gr", vim.lsp.buf.references, "References")
          map("n", "gi", vim.lsp.buf.implementation, "Implementation")
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
          map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
          map("n", "<leader>le", vim.diagnostic.open_float, "Show Diagnostic")
          map("n", "<leader>lq", vim.diagnostic.setloclist, "Diagnostic List")
        end,
      })

      -- Список серверов, установленных через Nix
      local servers = {
        "pyright",
        "nil_ls",
        "jsonls",
        "yamlls",
        "bashls",
        "sqls",
        "html",
        "cssls",
        "ts_ls",
        "lua_ls",
        "clangd",
        "taplo",
      }

      -- ✅ Применяем конфигурацию ко всем серверам через новый API
      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      -- Специфичные настройки для Python
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      -- Специфичные настройки для Lua
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Специфичные настройки для C/C++
      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })

      -- ✅ Включаем все настроенные серверы через новый API
      vim.lsp.enable({
        "pyright",
        "nil_ls",
        "jsonls",
        "yamlls",
        "bashls",
        "sqls",
        "html",
        "cssls",
        "ts_ls",
        "lua_ls",
        "clangd",
        "taplo",
      })
    end,
  },

  -- 4. Автодополнение
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  -- 5. None-ls (Форматирование и линтинг)
  {
    "nvimtools/none-ls.nvim",
    dependencies = { 
        "nvim-lspconfig", 
    "nvim-lua/plenary.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Python
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.mypy,
          -- C/C++
          null_ls.builtins.formatting.clang_format,
          -- Lua
          null_ls.builtins.formatting.stylua,
          -- Nix
          null_ls.builtins.formatting.nixfmt,
        },
      })
    end,
  },
}
