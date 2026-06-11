# ===== ОСНОВНАЯ КОНФИГУРАЦИЯ ZSH =====
# Этот файл переносим и может использоваться на любой Linux-системе

# ----- История команд -----
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS   # Убираем дубликаты
setopt HIST_SAVE_NO_DUPS      # Не сохраняем дубликаты
setopt HIST_REDUCE_BLANKS     # Убираем лишние пробелы
setopt INC_APPEND_HISTORY     # Добавляем в историю сразу
setopt SHARE_HISTORY          # Делимся историей между сессиями
setopt HIST_VERIFY            # Подтверждение перед выполнением из истории

# ----- Опции Zsh -----
setopt AUTO_CD                # Автоматический cd при вводе пути
setopt AUTO_PUSHD             # Автоматический pushd
setopt PUSHD_IGNORE_DUPS      # Не дублируем в стеке директорий
setopt PUSHD_SILENT           # Тихий pushd
setopt CORRECT                # Автоисправление команд
setopt COMPLETE_IN_WORD       # Автодополнение в слове
setopt NO_BEEP                # Отключаем beep
setopt EXTENDED_GLOB          # Расширенные glob-паттерны

# ----- Клавиатурные сокращения -----
bindkey -e                    # Emacs-стиль
bindkey '^[[A' history-search-backward   # Стрелка вверх - поиск по истории
bindkey '^[[B' history-search-forward    # Стрелка вниз - поиск по истории
bindkey '^[[3~' delete-char              # Delete
bindkey '^H' backward-kill-word          # Ctrl+Backspace

# ----- Алиасы -----
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Nix алиасы
alias nix-gc='sudo nix-collect-garbage -d'
alias nix-opt='sudo nix-store --optimise'
alias nix-up='sudo nixos-rebuild switch --flake ~/nixos-config#'
alias nix-flake-update='nix flake update ~/nixos-config'

# Git алиасы
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

# Безопасные алиасы
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ----- Direnv -----
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# ----- Локальные настройки (machine-specific) -----
# Создайте ~/.config/zsh/local.zsh для machine-specific настроек
if [[ -f "$HOME/.config/zsh/local.zsh" ]]; then
  source "$HOME/.config/zsh/local.zsh"
fi
