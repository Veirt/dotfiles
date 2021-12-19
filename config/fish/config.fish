set -U fish_greeting
fish_vi_key_bindings

bind -M insert \cf 'tmux-sessionizer.sh'
bind \cf 'tmux-sessionizer.sh'

bind -M insert \cr 'ranger'
bind \cr 'ranger'

source ~/.shell_aliases

# Starship prompt
if type starship &> /dev/null
    starship init fish | source
end
