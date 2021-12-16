set -U fish_greeting
fish_vi_key_bindings

bind -M insert \cf 'tmux-sessionizer.sh'
bind \cf 'tmux-sessionizer.sh'

bind -M insert \cr 'ranger'
bind \cr 'ranger'

function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end

set -gx EDITOR 'nvim'
set -gx VISUAL 'nvim'
set -gx GPG_TTY (tty)

source ~/.shell_aliases

set -a FZF_DEFAULT_OPTS --bind alt-j:down,alt-k:up
if type fd &> /dev/null
    export FZF_DEFAULT_COMMAND='fd --type f'
end

# Starship prompt
if type starship &> /dev/null
    starship init fish | source
end

