# ===== ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ =====
# Эти переменные загружаются ДО всего остального

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Nix-specific
export NIX_PATH="$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"
