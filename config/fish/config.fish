# Remove welcome message
set -U fish_greeting 

# I use arch btw
alias pacsyu="sudo pacman -Syu"
alias yaysyu="yay -Syu"

alias gs="git status"

alias ls="exa"

# Starship prompt
starship init fish | source
