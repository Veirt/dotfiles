set -g fish_greeting
fish_vi_key_bindings

bind -M insert \cf 'tmux-sessionizer'
bind \cf 'tmux-sessionizer'
bind -M insert \ct 'tmux'
bind \ct 'tmux'
bind -M insert \cr 'yy'
bind \cr 'yy'
bind -M insert \cg 'lbg $GUIFM .'
bind \cg 'lbg $GUIFM .'
bind -M insert \ce forward-char
bind \ce forward-char

source ~/.config/shell_aliases

if type -q mise
    mise activate fish | source
end

if type -q zoxide
    zoxide init fish | source
end

