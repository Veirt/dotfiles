set -U fish_greeting
fish_vi_key_bindings

bind -M insert \cf 'tmux-sessionizer'
bind \cf 'tmux-sessionizer'
bind -M insert \ct 'tmux'
bind \ct 'tmux'
bind -M insert \cr 'ranger'
bind \cr 'ranger'

source ~/.config/shell_aliases

# fish only aliases
alias google="web-search google"
alias github="web-search github"
alias stackoverflow="web-search stackoverflow"

set -gx WEB_SEARCH_flac 'https://nyaa.si/?f=0&c=2_1&q='
set -gx WEB_SEARCH_anime 'https://nyaa.si/?f=0&c=1_2&q='
set -gx WEB_SEARCH_dict 'https://dictionary.cambridge.org/dictionary/english/'
