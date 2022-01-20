export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.local/cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export HISTFILE="$XDG_STATE_HOME/zsh/history"

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
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

export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export PYTHONHISTFILE="$XDG_STATE_HOME/python/python_history"
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export VSCODE_PORTABLE="$XDG_DATA_HOME/vscode"
