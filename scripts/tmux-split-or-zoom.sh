#!/usr/bin/bash

# count lines
TMUX_PANES=$(tmux list-panes | wc -l)

if [ $TMUX_PANES == 1 ]
then
    tmux split-window -v -l 13
else
    tmux resize-pane -Z
fi
