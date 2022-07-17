export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL='foot'
export LAUNCH_TERMINAL='foot'
export BROWSER='firefox'
export GUIFM='thunar'
export TUIFM='ranger'

export PATH=$XDG_DATA_HOME/npm/bin:$PATH
export PATH=$XDG_DATA_HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.local/cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
# export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export MOZ_WEBRENDER=1
export MOZ_ENABLE_WAYLAND=1

export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

# home dir cleanups
export HISTFILE="$XDG_STATE_HOME/bash/history"
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export FFMPEG_DATADIR="$XDG_CONFIG_HOME/ffmpeg"

export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/rediscli_history"
export REDISCLI_RCFILE="$XDG_CONFIG_HOME/redis/redisclirc"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"

export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export VSCODE_PORTABLE="$XDG_DATA_HOME/vscode"

# configurations
export PF_INFO="ascii os wm uptime pkgs memory palette"

if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
fi

export FZF_DEFAULT_OPTS="--prompt='❱ ' --bind alt-j:down,alt-k:up"

# set XDG_RUNTIME_DIR
if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
	if ! test -d "${XDG_RUNTIME_DIR}"; then
		mkdir "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi
fi
