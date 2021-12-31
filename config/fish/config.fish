set -U fish_greeting
fish_vi_key_bindings

bind -M insert \cf 'tmux-sessionizer.sh'
bind \cf 'tmux-sessionizer.sh'

bind -M insert \cr 'ranger'
bind \cr 'ranger'

source ~/.config/shell_aliases

if type zoxide &> /dev/null
    zoxide init fish | source
end
