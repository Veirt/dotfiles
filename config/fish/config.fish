set -U fish_greeting
fish_vi_key_bindings

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

thefuck --alias | source

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
alias ct="cargo test"

#get fastest mirrors in your neighborhood
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
#our experimental - best option for the moment
alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias mirrorxx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"

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
# starship init fish | source

