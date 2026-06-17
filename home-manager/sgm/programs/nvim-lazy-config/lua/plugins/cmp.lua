i-- lua/plugins/cmp.lua
-- ============================================================
-- СПЕЦИФИКАЦИИ ПЛАГИНОВ АВТОДОПОЛНЕНИЯ (NVIM-CMP)
-- ============================================================
-- Здесь ТОЛЬКО спецификации плагинов и event для ленивой загрузки.
-- Все хоткеи вынесены в mappings/cmp.lua.

return {
  -- 1. Ядро фреймворка автодополнения
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- Источники данных
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- Движок сниппетов
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- Коллекция готовых сниппетов для всех языков
      "rafamadriz/friendly-snippets",
      -- Иконки для элементов автодополнения
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Загружаем сниппеты из friendly-snippets (VS Code совместимые)
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Настройка самого фреймворка cmp
      cmp.setup({
        -- === Сниппеты ===
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- === Окно документации и меню ===
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- === Форматирование элементов (иконки от lspkind) ===
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", -- Иконка + текст
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },

        -- === Маппинги (все хоткеи здесь, т.к. они специфичны для cmp) ===
        -- Примечание: хоткеи навигации по файлам/буферам остаются в keymaps/,
        -- а хоткеи управления меню автодополнения — здесь, т.к. они работают
        -- только когда меню активно (cmp.mapping).
        mapping = cmp.mapping.preset.insert({
          -- Закрытие меню
          ["<C-e>"] = cmp.mapping.abort(),
          -- Подтверждение выбора
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- Ручной вызов меню
          ["<C-Space>"] = cmp.mapping.complete(),
          -- Прокрутка документации
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),

          -- Навигация + работа со сниппетами
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              -- Если меню открыто — выбираем следующий элемент
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              -- Если можно раскрыть сниппет или перейти дальше — делаем это
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Навигация стрелками
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- === Источники данных (в порядке приоритета) ===
        sources = cmp.config.sources({
          { name = "nvim_lsp",              priority = 1000 },
          { name = "nvim_lsp_signature_help", priority = 900 },
          { name = "luasnip",               priority = 750 },
          { name = "path",                  priority = 500 },
        }, {
          { name = "buffer",                priority = 250 },
        }),

        -- === Подтверждение выбора ===
        -- Авто-подтверждение при выборе единственного варианта
        confirmation = {
          default_behavior = cmp.ConfirmBehavior.Replace,
        },

        -- === Сортировка ===
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

        -- === Экспериментальные функции ===
        experimental = {
          ghost_text = {
            char = "󰊠",
            hl_group = "CmpItemKind",
          },
        },
      })

      -- === Настройка cmdline (командная строка Neovim) ===
      -- Поиск по / и ?
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Команды Neovim (:)
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
