-- lua/plugins/nvim-tree.lua
return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFocus",
      "NvimTreeFindFile",
    },
    -- ✅ Только ОДИН хоткей для открытия/закрытия
    keys = {
      { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    },
    config = function()
      -- Отключаем netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        -- Синхронизация
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },

        -- Поведение
        open_on_tab = false,
        hijack_cursor = false,

        -- Вид
        view = {
          width = 35,
          side = "left",
          preserve_window_proportions = false,
          number = false,
          relativenumber = false,
          signcolumn = "yes",
        },

        -- Рендерер
        renderer = {
          root_folder_label = ":~:s?$?/..?",
          indent_width = 2,
          indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              diagnostics = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              bookmark = "",
              modified = "●",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
          special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "flake.nix" },
          symlink_destination = true,
          group_empty = false,
        },

        -- Фильтры
        filters = {
          dotfiles = false,
          git_ignored = true,
          custom = { ".git", "node_modules", ".cache", "__pycache__", "target", "dist", "build" },
        },

        -- Git интеграция
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
          timeout = 400,
        },

        -- Диагностика
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          show_on_open_dirs = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },

        -- Действия
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
              enable = true,
              picker = "default",
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
          remove_file = {
            close_window = true,
          },
        },

        -- Уведомления
        notify = {
          threshold = vim.log.levels.INFO,
        },

        -- UI
        ui = {
          confirm = {
            remove = true,
            trash = true,
            default_yes = false,
          },
        },

        -- Логирование
        log = {
          enable = false,
          truncate = false,
          types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
          },
        },
      })

      -- Автокоманда: закрывать NvimTree, если это последний буфер
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
        pattern = "NvimTree_*",
        callback = function()
          local layout = vim.api.nvim_win_get_config(0).relative
          if layout ~= "" then
            return
          end
          if #vim.api.nvim_list_wins() == 1 then
            vim.cmd("quit")
          end
        end,
      })
    end,
  },
}
