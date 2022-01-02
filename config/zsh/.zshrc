# fuck beep
unsetopt BEEP

# i hate slow
KEYTIMEOUT=1

source ~/.config/shell_aliases

bindkey -s "^F" 'tmux-sessionizer.sh^M'
bindkey -s "^R" 'ranger^M'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

if [[ ! -f ~/.local/share/zpm/zpm.zsh ]]; then
  git clone --recursive https://github.com/zpm-zsh/zpm ~/.local/share/zpm
fi
source ~/.local/share/zpm/zpm.zsh

AUTOPAIR_INHIBIT_INIT=1
ZVM_CURSOR_STYLE_ENABLED=false

zpm load zsh-users/zsh-autosuggestions
zpm load zdharma-continuum/fast-syntax-highlighting
zpm load hlissner/zsh-autopair
zpm load jeffreytse/zsh-vi-mode

autopair-init

eval "$(zoxide init zsh)"
eval `starship init zsh`
