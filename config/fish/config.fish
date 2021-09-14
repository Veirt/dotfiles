set -U fish_greeting
fish_vi_key_bindings
bind -M insert \cf 'tmux-sessionizer.sh'
bind \cf 'tmux-sessionizer.sh'

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

export EDITOR='nvim'
export VISUAL='nvim'

source ~/.shell_aliases

# Starship prompt
starship init fish | source 

