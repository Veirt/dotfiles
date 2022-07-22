set -U fish_greeting
fish_vi_key_bindings

bind -M insert \cf 'tmux-sessionizer'
bind \cf 'tmux-sessionizer'

source ~/.config/shell_aliases

# fish only aliases
alias google="web-search google"
alias github="web-search github"
alias stackoverflow="web-search stackoverflow"
