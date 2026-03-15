set -U fish_greeting
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

function source_local_env --argument-names envfile
    if not test -f $envfile
        return
    end

    while read -l line
        set line (string trim -- $line)

        if test -z "$line"
            continue
        end

        if string match -qr '^#' -- $line
            continue
        end

        set line (string replace -r '^export[[:space:]]+' '' -- $line)

        if not string match -qr '^[A-Za-z_][A-Za-z0-9_]*=' -- $line
            continue
        end

        set parts (string split -m 1 '=' -- $line)
        set key $parts[1]
        set raw_value $parts[2]
        eval "set -gx $key $raw_value"
    end < $envfile
end

source ~/.config/shell_aliases
source_local_env "$HOME/.config/secrets/.local.env"

set -gx WEB_SEARCH_flac 'https://nyaa.si/?f=0&c=2_1&q='
set -gx WEB_SEARCH_anime 'https://nyaa.si/?f=0&c=1_2&q='
set -gx WEB_SEARCH_dict 'https://dictionary.cambridge.org/dictionary/english/'
set -gx WEB_SEARCH_hi10 'https://hi10anime.com/?s='
set -gx WEB_SEARCH_mal 'https://myanimelist.net/search/all?cat=all&q='

# fix valgrind
set -x DEBUGINFOD_URLS 'https://debuginfod.archlinux.org'

alias google="web-search google"
alias github="web-search github"
alias anime="web-search anime"
alias hi10="web-search hi10"
alias mal="web-search mal"
alias yt="web-search youtube"
alias opt="web-search nixoptions"
alias pkg="web-search nixpkgs"

if type -q zoxide
    zoxide init fish | source
end

if type -q direnv
    direnv hook fish | source
end
