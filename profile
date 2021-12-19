# export QT_QPA_PLATFORM=wayland
# export MOZ_ENABLE_WAYLAND=1
# export XDG_CURRENT_DESKTOP=sway

export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL='kitty'
export BROWSER='firefox'
export MOZ_WEBRENDER=1

export GPG_TTY=(tty)

export PATH=~/.npm-global/bin:$PATH
export PATH=~/go/bin:$PATH

if command -v fd &> /dev/null
then
    export FZF_DEFAULT_COMMAND='fd --type f'
fi

