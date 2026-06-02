# ~/nixos-config/home-manager/sgm/programs/neovim/core/keymaps.nix
{...}: {
  keymaps = [
    # ── Общие ───────────────────────────────────────
    {
      key = "<leader>w";
      action = "<cmd>w<CR>";
      options.desc = "Сохранить файл";
    }
    {
      key = "<leader>q";
      action = "<cmd>q<CR>";
      options.desc = "Закрыть окно";
    }
    {
      key = "<Esc>";
      action = "<cmd>noh<CR>";
      options.desc = "Убрать подсветку поиска";
    }

    # ── Проводник (Snacks.explorer) ─────────────────
    {
      key = "<leader>e";
      action.__raw = "function() Snacks.explorer() end";
      options.desc = "Открыть проводник";
    }
    {
      key = "<leader>E";
      action.__raw = "function() Snacks.explorer({cwd = vim.fn.expand('%:p:h')}) end";
      options.desc = "Проводник в текущей папке";
    }

    # ── Поиск (Telescope) ───────────────────────────
    {
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      options.desc = "Найти файлы";
    }
    {
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
      options.desc = "Живой grep";
    }
    {
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<CR>";
      options.desc = "Список буферов";
    }
    {
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<CR>";
      options.desc = "Теги справки";
    }

    # ── LSP (языковой сервер) ──────────────────────
    {
      key = "gd";
      action.__raw = "function() vim.lsp.buf.definition() end";
      options.desc = "Перейти к определению";
    }
    {
      key = "gD";
      action.__raw = "function() vim.lsp.buf.references() end";
      options.desc = "Показать ссылки";
    }
    {
      key = "K";
      action.__raw = "function() vim.lsp.buf.hover() end";
      options.desc = "Информация под курсором";
    }
    {
      key = "<leader>rn";
      action.__raw = "function() vim.lsp.buf.rename() end";
      options.desc = "Переименовать";
    }
    {
      key = "<leader>ca";
      action.__raw = "function() vim.lsp.buf.code_action() end";
      options.desc = "Действия с кодом";
    }
    {
      key = "]d";
      action.__raw = "function() vim.diagnostic.goto_next() end";
      options.desc = "Следующая ошибка";
    }
    {
      key = "[d";
      action.__raw = "function() vim.diagnostic.goto_prev() end";
      options.desc = "Предыдущая ошибка";
    }

    # ── Git ───────────────────────────────────────
    {
      key = "<leader>gg";
      action = "<cmd>LazyGit<CR>";
      options.desc = "Открыть LazyGit";
    }
    {
      key = "<leader>gb";
      action.__raw = "function() require('gitsigns').blame_line{full=true} end";
      options.desc = "История строки (blame)";
    }

    # ── Отладка (DAP) ──────────────────────────────
    {
      key = "<leader>db";
      action.__raw = "function() require('dap').toggle_breakpoint() end";
      options.desc = "Точка останова";
    }
    {
      key = "<leader>dc";
      action.__raw = "function() require('dap').continue() end";
      options.desc = "Продолжить/начать отладку";
    }
    {
      key = "<leader>do";
      action.__raw = "function() require('dap').step_over() end";
      options.desc = "Шаг через";
    }
    {
      key = "<leader>di";
      action.__raw = "function() require('dap').step_into() end";
      options.desc = "Шаг внутрь";
    }
    {
      key = "<leader>du";
      action.__raw = "function() require('dap').step_out() end";
      options.desc = "Шаг из";
    }
    {
      key = "<leader>dq";
      action.__raw = "function() require('dap').terminate() end";
      options.desc = "Завершить сеанс";
    }
    {
      key = "<leader>dui";
      action.__raw = "function() require('dapui').toggle() end";
      options.desc = "Toggle DAP UI";
    }

    # ── Сообщения (логи) ──────────────────────────
    {
      key = "<leader>vm";
      action.__raw = "function() Snacks.notifier.show_history() end";
      options.desc = "История уведомлений";
    }
  ];
}
