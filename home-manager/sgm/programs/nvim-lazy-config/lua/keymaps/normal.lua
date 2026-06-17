-- lua/keymaps/normal.lua
-- ============================================================
-- ГЛОБАЛЬНЫЕ ПРИВЯЗКИ NORMAL MODE
-- ============================================================

local map = require("core.utils").map

-- === Which-Key: Определение групп ===
-- Эти группы будут показаны в which-key при нажатии <leader>
local wk = require("core.utils").safe_require("which-key")
if wk then
  wk.add({
    { "<leader>e", group = "Explorer" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>x", group = "Diagnostics" },
    { "<leader>b", group = "Buffer" },
    { "<leader>w", group = "Window" },
    { "<leader>T", group = "Terminal" },
    { "<leader>c", group = "Config" },
  })
end

-- === Навигация между окнами ===
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- === Изменение размера окон ===
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize up" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize down" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize left" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize right" })

-- === Навигация по буферам ===
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", ":%bdelete<CR>", { desc = "Delete all buffers" })

-- === Перемещение строк ===
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- === Сохранение и выход ===
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>W", ":wa<CR>", { desc = "Save all" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all (force)" })

-- === Очистка поиска ===
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- === Буфер обмена ===
map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+yg_', { desc = "Yank line to clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste before from clipboard" })

-- === Быстрый доступ к файлам конфигурации Neovim ===
map("n", "<leader>cn", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Edit Neovim init.lua" })

map("n", "<leader>co", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/lua/core/options.lua")
end, { desc = "Edit options.lua" })

-- === Перезагрузка конфигурации ===
map("n", "<leader>cr", function()
  for k, _ in pairs(package.loaded) do
    if k:match("^core%.") or k:match("^plugins%.") or
       k:match("^config%.") or k:match("^mappings%.") or
       k:match("^keymaps%.") then
      package.loaded[k] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  require("core.init")
  vim.notify("Configuration reloaded!", vim.log.levels.INFO, { title = "Neovim" })
end, { desc = "Reload configuration" })

-- === Терминал ===
map("n", "<leader>Tt", ":terminal<CR>", { desc = "Open terminal" })
map("n", "<leader>Tf", ":terminal fish<CR>", { desc = "Open fish terminal" })

-- === Отмена/повтор ===
map("n", "U", "<C-r>", { desc = "Redo" })
