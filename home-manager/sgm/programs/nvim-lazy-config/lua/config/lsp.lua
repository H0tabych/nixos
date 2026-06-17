-- lua/config/lsp.lua
-- ============================================================
-- НАСТРОЙКА LSP-СЕРВЕРОВ
-- ============================================================

local M = {}

function M.setup()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- === On_attach: хоткеи LSP ===
  -- Эта функция вызывается при подключении LSP к буферу
  local on_attach = function(client, bufnr)
    -- Загружаем хоткеи из mappings/lsp.lua
    require("mappings.lsp").setup(bufnr)
  end

  -- === Nix (nil) ===
  lspconfig.nil_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      ["nil"] = {
        formatting = {
          command = { "nixfmt" },
        },
      },
    },
  })

  -- === Lua (lua-language-server + neodev) ===
  -- neodev.nvim автоматически настраивает lua_ls, но мы добавляем on_attach
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    -- neodev сам настроит settings, но можно добавить свои
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" }, -- Глобальная переменная vim
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })

  -- === Vim (vim-language-server) ===
  lspconfig.vimls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- === Глобальные настройки диагностик ===
  vim.diagnostic.config({
    virtual_text = {
      prefix = "●", -- Символ перед диагностикой
      severity = {
        min = vim.diagnostic.severity.WARN, -- Показывать только warnings и errors
      },
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = true, -- Показывать источник диагностики
      header = "",
      prefix = "",
    },
  })

  -- === Иконки для диагностик ===
  local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return M
