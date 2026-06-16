-- lua/config/telescope.lua
local M = {}

function M.setup()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        },
      },
      file_ignore_patterns = {
        "node_modules",
        ".git/",
        "target/",
        "dist/",
        "build/",
      },
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = false,
      },
      live_grep = {
        theme = "ivy",
      },
    },
  })

  -- Загрузить fzf extension если доступен
  pcall(telescope.load_extension, "fzf")
end

return M
