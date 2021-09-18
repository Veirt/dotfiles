#!/usr/bin/env bash
selected=`cat ~/.tmux-cht-languages ~/.tmux-cht-command | fzf`
echo "Selected: $selected"
read -p "Enter Query: " query
query=`echo $query | tr ' ' '+'`

if grep -qs "$selected" ~/.tmux-cht-languages; then
    echo "curl cht.sh/$selected/$query"
    tmux neww bash -c "curl -s cht.sh/$selected/$query | bat --paging=always --style=plain"
else
    echo "curl cht.sh/$selected~$query"
    tmux neww bash -c "curl -s cht.sh/$selected~$query | bat --paging=always --style=plain"
fi

