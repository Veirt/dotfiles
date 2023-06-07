export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL='foot'
export LAUNCH_TERMINAL='foot'
export BROWSER='firefox'
export GUIFM='thunar'
export TUIFM='ranger'

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.local/cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export PATH=$HOME/.local/bin:$PATH
export PATH=$XDG_DATA_HOME/npm/bin:$PATH
export PATH=$XDG_DATA_HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

export ANDROID_SDK_ROOT='/opt/android-sdk'
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/

# configurations
export PF_INFO="ascii os wm uptime pkgs memory palette"

if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
fi

export FZF_DEFAULT_OPTS="--prompt='❱ ' --bind alt-j:down,alt-k:up"

if [[ -d "$HOME/.personal/profile" ]]; then
    for f in "$HOME"/.personal/profile/*; do source "$f"; done
fi
