set -U fish_greeting
fish_vi_key_bindings

bind -M insert \cf 'tmux-sessionizer'
bind \cf 'tmux-sessionizer'
bind -M insert \ct 'tmux'
bind \ct 'tmux'
bind -M insert \cr 'lfcd'
bind \cr 'lfcd'
bind -M insert \cg 'lbg $GUIFM .'
bind \cg 'lbg $GUIFM .'
bind -M insert \ce forward-char
bind \ce forward-char

source ~/.config/shell_aliases

set -gx WEB_SEARCH_flac 'https://nyaa.si/?f=0&c=2_1&q='
set -gx WEB_SEARCH_anime 'https://nyaa.si/?f=0&c=1_2&q='
set -gx WEB_SEARCH_dict 'https://dictionary.cambridge.org/dictionary/english/'
set -gx WEB_SEARCH_hi10 'https://hi10anime.com/?s='
set -gx WEB_SEARCH_mal 'https://myanimelist.net/search/all?cat=all&q='

# fix valgrind
set -x DEBUGINFOD_URLS 'https://debuginfod.archlinux.org'

alias google="web-search google"
alias github="web-search github"
alias stackoverflow="web-search stackoverflow"
alias anime="web-search anime"
alias hi10="web-search hi10"
alias mal="web-search mal"

if type -q zoxide
    zoxide init fish | source
end
