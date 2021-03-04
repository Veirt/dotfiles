# Remove welcome message
set -U fish_greeting 

# I use arch btw
alias pacsyu="sudo pacman -Syu"

alias gs="git status"

alias ls="exa"

# Starship prompt
starship init fish | source
if not set -q TMUX
    set -g TMUX tmux new-session -d -s base
    eval $TMUX
    tmux attach-session -d -t base
end
