-- lua/config/lsp.lua
-- ============================================================
-- НАСТРОЙКА LSP-СЕРВЕРОВ (НОВЫЙ API Neovim 0.11+)
-- ============================================================

local M = {}

function M.setup()
  -- === Получаем capabilities от cmp ===
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- === On_attach: хоткеи LSP ===
  -- Эта функция вызывается при подключении LSP к буферу
  local on_attach = function(client, bufnr)
    -- Загружаем хоткеи из mappings/lsp.lua
    require("mappings.lsp").setup(bufnr)
  end

  -- === Настройки по умолчанию для всех серверов ===
  -- Используем новый API vim.lsp.config("*", {...})
  vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- === Nix (nil) ===
  vim.lsp.config("nil_ls", {
    settings = {
      ["nil"] = {
        formatting = {
          command = { "nixfmt" },
        },
      },
    },
  })

  -- === Lua (lua-language-server + neodev) ===
  -- neodev.nvim автоматически настраивает lua_ls, но мы добавляем свои настройки
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
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
  vim.lsp.config("vimls", {})

  -- === Включаем все настроенные серверы ===
  -- Используем новый API vim.lsp.enable({...})
  vim.lsp.enable({
    "nil_ls",
    "lua_ls",
    "vimls",
  })

  -- === Глобальные настройки диагностик ===
  vim.diagnostic.config({
    virtual_text = {
      prefix = "●",
      severity = {
        min = vim.diagnostic.severity.WARN,
      },
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = true,
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
