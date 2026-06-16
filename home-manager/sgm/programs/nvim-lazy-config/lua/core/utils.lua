-- lua/core/utils.lua
local M = {}

-- Безопасная загрузка модуля с уведомлением об ошибке
function M.safe_require(module_name)
  local ok, module = pcall(require, module_name)
  if not ok then
    vim.notify("Failed to load module: " .. module_name, vim.log.levels.WARN)
    return nil
  end
  return module
end

-- Проверка наличия исполняемого файла
function M.is_executable(cmd)
  return vim.fn.executable(cmd) == 1
end

-- Получить путь к проекту
function M.get_project_root()
  local lsp_util = vim.lsp.util
  if lsp_util and lsp_util.get_workspace_folder then
    local root = lsp_util.get_workspace_folder()
    if root then return root end
  end
  return vim.fn.getcwd()
end

-- Уведомление
function M.notify(msg, level)
  level = level or vim.log.levels.INFO
  vim.notify(msg, level, {
    title = "Neovim",
    timeout = 3000,
  })
end

return M
