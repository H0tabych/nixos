-- lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable("make") == 1 end },
    },
    -- ✅ Только команда для ленивой загрузки. Хоткеи вынесены в mappings/telescope.lua
    cmd = { "Telescope" },
    opts = {
      defaults = {
        preview = { treesitter = false },
        file_ignore_patterns = { "node_modules/", "%.git/", "target/", "dist/", "build/", "out/", "__pycache__/", "%.venv/", "venv/" },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
          vertical = { mirror = false },
          width = 0.87, height = 0.80, preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-u>"] = false, ["<C-d>"] = false,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            ["<Esc>"] = require("telescope.actions").close,
          },
          n = { ["q"] = require("telescope.actions").close },
        },
      },
      pickers = {
        find_files = { theme = "dropdown", previewer = false },
        live_grep = { theme = "ivy" },
        buffers = { theme = "dropdown", previewer = false },
        help_tags = { theme = "dropdown" },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
