-- lua/core/utils.lua
-- ============================================================
-- УТИЛИТЫ КОНФИГУРАЦИИ
-- ============================================================
-- Вспомогательные функции, используемые во всей конфигурации.

local M = {}

-- Безопасная загрузка модуля
-- Если модуль не найден или содержит ошибку, возвращает nil
-- и выводит предупреждение, но не ломает всю конфигурацию.
function M.safe_require(module_name)
  local ok, module = pcall(require, module_name)
  if not ok then
    -- Не выводим ошибку, если модуль просто ещё не создан
    -- (мы добавим их на следующих этапах)
    if not string.find(module, "module '" .. module_name .. "' not found") then
      vim.notify(
        "Failed to load module: " .. module_name .. "\n" .. module,
        vim.log.levels.WARN,
        { title = "Config" }
      )
    end
    return nil
  end
  return module
end

-- Проверка наличия исполняемого файла в PATH
function M.is_executable(cmd)
  return vim.fn.executable(cmd) == 1
end

-- Проверка, что плагин загружен
function M.has(plugin_name)
  local ok = pcall(require, plugin_name)
  return ok
end

-- Получить корневую директорию проекта
-- Ищет .git, .svn, или package.json вверх по дереву
function M.get_project_root()
  local patterns = { ".git", ".hg", ".svn", "package.json", "flake.nix", "Cargo.toml" }
  local path = vim.fn.findfile(patterns[1], ".;")
  if path ~= "" then
    return vim.fn.fnamemodify(path, ":p:h")
  end
  return vim.fn.getcwd()
end

-- Уведомление с форматированием
function M.notify(msg, level, opts)
  level = level or vim.log.levels.INFO
  opts = opts or {}
  opts.title = opts.title or "Neovim"
  opts.timeout = opts.timeout or 3000
  vim.notify(msg, level, opts)
end

-- Маппинг с описанием (сокращение для vim.keymap.set)
function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Буферный маппинг (для LSP и подобных)
function M.buf_map(bufnr, mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.buffer = bufnr
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
