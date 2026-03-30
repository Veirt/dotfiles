source ~/.config/shell_aliases
[ -f "$HOME/.config/secrets/.local.env" ] && . "$HOME/.config/secrets/.local.env"

if command -v rg &> /dev/null; then
    alias grep='rg'
fi

# . "/home/veirt/.deno/env"
