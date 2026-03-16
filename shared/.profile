if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

export EDITOR='nvim'
export VISUAL='nvim'
export BROWSER='firefox'
export GUIFM='nautilus'
export TUIFM='yazi'

export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM="wayland"
# export XDG_CURRENT_DESKTOP=sway
# export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wlroots
export MOZ_WEBRENDER=1
export MOZ_ENABLE_WAYLAND=1
export GDK_BACKEND=wayland

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$XDG_DATA_HOME/npm/bin:$PATH"
export PATH="$XDG_DATA_HOME/go/bin:$PATH"
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

export PNPM_HOME="$HOME/.local/share/pnpm"
export BUN_INSTALL="$HOME/.local/share/bun"
# export ANDROID_SDK_ROOT="$HOME/.local/share/android/sdk"
# export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools/"
# export PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin/"
# export PATH="$PATH:$ANDROID_ROOT/emulator"
# export PATH="$PATH:$ANDROID_SDK_ROOT/tools/"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
# export PATH="$PATH:/usr/lib/jvm/default/bin"
export PATH="$PATH:$PNPM_HOME"
export PATH="$PATH:$BUN_INSTALL/bin"
export PATH="$PATH:$HOME/.dotnet"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
export CHROME_EXECUTABLE=google-chrome-stable

if [ -f "$HOME/.config/secrets/.local.env" ]; then
    . "$HOME/.config/secrets/.local.env"
fi

# configurations
export PF_INFO="ascii os wm uptime pkgs memory palette"

if command -v fd >/dev/null 2>/dev/null; then
    export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
fi

export FZF_DEFAULT_OPTS="--prompt='❱ ' --bind alt-j:down,alt-k:up"

if [ -d "$HOME/.personal/profile" ]; then
    for f in "$HOME"/.personal/profile/*; do . "$f"; done
fi
if [ -f "$HOME/.deno/env" ]; then
    . "$HOME/.deno/env"
fi
