set -U fish_greeting
function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end

# I use arch btw
alias pacsyu="sudo pacman -Syu"

alias bluetooth="bluetoothctl"

alias gs="git status"
alias ga="git add"
alias ls="exa"
alias la="exa -la"
alias ll="exa -ll"

alias repo="cd ~/Repositories"
alias dotfiles="cd ~/.dotfiles"

# Starship prompt
# starship init fish | source
