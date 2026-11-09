function q --argument-names prompt
    pi -p "$prompt"
end

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

        set line (string replace -r '^export[[:space:]]+' "" -- $line)

        if not string match -qr '^[A-Za-z_][A-Za-z0-9_]*=' -- $line
            continue
        end

        set parts (string split -m 1 '=' -- $line)
        set key $parts[1]
        set raw_value $parts[2]
        eval "set -gx $key $raw_value"
    end < $envfile
end

source_local_env "$HOME/.config/secrets/.local.env"

set -gx WEB_SEARCH_flac 'https://nyaa.si/?f=0&c=2_1&q='
set -gx WEB_SEARCH_anime 'https://nyaa.si/?f=0&c=1_2&q='
set -gx WEB_SEARCH_dict 'https://dictionary.cambridge.org/dictionary/english/'
set -gx WEB_SEARCH_hi10 'https://hi10anime.com/?s='
set -gx WEB_SEARCH_mal 'https://myanimelist.net/search/all?cat=all&q='
