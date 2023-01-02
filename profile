export EDITOR='nvim'
export VISUAL='nvim'

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.local/cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export PATH=$HOME/.local/bin:$PATH
export PATH=$XDG_DATA_HOME/npm/bin:$PATH
export PATH=$XDG_DATA_HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

# configurations
export PF_INFO="ascii os wm uptime pkgs memory palette"

if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
fi

export FZF_DEFAULT_OPTS="--prompt='❱ ' --bind alt-j:down,alt-k:up"

source $HOME/.personal/profile/*
