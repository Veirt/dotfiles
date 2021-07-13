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
end

export EDITOR='nvim'
export VISUAL='nvim'

alias pacsyu="sudo pacman -Syu"

alias bluetooth="bluetoothctl"

alias gs="git status"
alias ga="git add"
alias ls="exa"
alias la="exa -la"
alias ll="exa -ll"
alias yeet="rm -rf"

alias repo="cd ~/Repositories"
alias dotfiles="cd ~/.dotfiles"

alias vi="nvim"
alias vim="nvim"

alias py="python"
alias cr="cargo run"
alias cc="cargo check"
alias cb="cargo build"

#youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "

alias ytv-best="youtube-dl -f bestvideo+bestaudio "

# Starship prompt
starship init fish | source
