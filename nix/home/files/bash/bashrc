source ~/.config/shell_aliases
[ -f "$HOME/.config/secrets/.local.env" ] && . "$HOME/.config/secrets/.local.env"

# . "/home/veirt/.deno/env"

export HISTFILE="$HOME/.local/share/bash/history"
mkdir -p "${HISTFILE%/*}"

if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash)"
fi

# Vite+ bin (https://viteplus.dev)
[ -f "$HOME/.vite-plus/env" ] && . "$HOME/.vite-plus/env"
