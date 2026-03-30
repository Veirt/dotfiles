set -U fish_greeting
fish_vi_key_bindings

function source_home_manager_session
    set -l hm_session_vars "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

    if not test -f $hm_session_vars
        return
    end

    set -l imported_vars (sh -lc 'set -a; . "$1" >/dev/null 2>&1; env -0' sh $hm_session_vars | string split0)

    for entry in $imported_vars
        set -l parts (string split -m 1 '=' -- $entry)

        if test (count $parts) -eq 2
            if contains -- $parts[1] PWD SHLVL _ fish_greeting pipestatus status version
                continue
            end

            set -gx $parts[1] $parts[2]
        end
    end
end

source_home_manager_session

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

if type -q lure
    lure fish init | source
end
