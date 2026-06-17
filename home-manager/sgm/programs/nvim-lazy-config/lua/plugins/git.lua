-- lua/plugins/git.lua
return {
  -- 1. Neogit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    cmd = { "Neogit" },
    -- ✅ ИСПРАВЛЕНО: commit_editor теперь таблица (или убран для дефолта)
    opts = {
      integrations = { telescope = true, diffview = true },
      auto_refresh = true,
      use_builtin_diffview = true,
      graph_style = "kitty",
      signs = {
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
      },
      -- ✅ ИСПРАВЛЕНИЕ: commit_editor теперь таблица
      commit_editor = {
        kind = "tab",           -- "split", "vsplit", "tab", "split_above", "auto"
        show_staged = true,     -- Показывать staged изменения в редакторе коммита
      },
      notification_title = function(msg)
        return "Neogit: " .. msg
      end,
    },
  },

  -- 2. Diffview
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    opts = {
      use_diagnostic_signs = true,
      file_panel = {
        listing_style = "tree",
        win_config = { position = "left", width = 35 },
      },
    },
  },

  -- 3. Lazygit
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    config = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_use_neovim_remote = true
    end,
  },
}
