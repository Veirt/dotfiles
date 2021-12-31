# fuck beep
unsetopt BEEP

source ~/.config/shell_aliases

bindkey -s "^F" 'tmux-sessionizer.sh^M'
bindkey -s "^R" 'ranger^M'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

if [[ ! -f ~/.local/share/zpm/zpm.zsh ]]; then
  git clone --recursive https://github.com/zpm-zsh/zpm ~/.local/share/zpm
fi
source ~/.local/share/zpm/zpm.zsh

