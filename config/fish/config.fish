set -U fish_greeting
function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end # I use arch btw
alias pacsyu="sudo pacman -Syu"

alias bluetooth="bluetoothctl"

alias gs="git status"
alias ga="git add"
alias ls="exa"
alias la="exa -la --icons"
alias ll="exa -ll --icons"

alias repo="cd ~/Repositories"
alias dotfiles="cd ~/.dotfiles"

alias vi="nvim"
alias vim="nvim"

alias py="python"
alias cr="cargo run"
alias cc="cargo check"
alias cb="cargo build"

# Starship prompt
starship init fish | source
