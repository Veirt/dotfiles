#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    items=`find ~/Repositories -maxdepth 1 -mindepth 1 -type d`
    items+="\n$HOME/.dotfiles"
    selected=`echo -e "$items" | fzf`
fi

# check if selected is not empty
if [ -z $selected ]; then
    exit 0
else
    echo "selected: $selected"
    tmux_session_name=`basename $selected | tr . _`

    tmux switch-client -t $tmux_session_name
    if [[ $? -eq 0 ]]; then
        exit 0
    fi

    tmux new-session -c $selected -d -s $tmux_session_name && tmux switch-client -t $tmux_session_name || tmux new -c $selected -A -s $tmux_session_name
fi

