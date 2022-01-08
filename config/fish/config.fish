set -U fish_greeting
fish_vi_key_bindings

bind -M insert \cf 'tmux-sessionizer.sh'
bind \cf 'tmux-sessionizer.sh'

bind -M insert \cr 'ranger'
bind \cr 'ranger'

source ~/.config/shell_aliases

# fish only aliases
alias google="web-search google"
alias github="web-search github"
alias stackoverflow="web-search stackoverflow"

if type zoxide &> /dev/null
    zoxide init fish | source
end
