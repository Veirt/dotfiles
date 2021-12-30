#!/bin/sh

selected=$(cat ~/.tmux/tmux-cht-languages ~/.tmux/tmux-cht-command | fzf --print-query | tail -1 | xargs -r)
echo "Selected: $selected"
read -p "Enter Query: " query
query=$(echo $query | tr ' ' '+')

if grep -qs "$selected" ~/.tmux/tmux-cht-command; then
    # echo "curl cht.sh/$selected~$query" | less
    tmux neww bash -c "curl -s cht.sh/$selected~$query | bat --paging=always --style=plain"
else
    # echo "curl cht.sh/$selected/$query" | less
    tmux neww bash -c "curl -s cht.sh/$selected/$query | bat --paging=always --style=plain"
fi
