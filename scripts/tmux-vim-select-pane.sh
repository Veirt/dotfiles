#!/usr/bin/env bash
# Like `tmux select-pane`, but if Vim is running in the current pane it sends
# a `<C-h/j/k/l>` keystroke to Vim instead.
set -e

cmd="$(tmux display -p '#{pane_current_command}')"
cmd="$(basename "$cmd" | tr A-Z a-z)"

if [ "${cmd}" = "nvim" ]; then
    direction="$(echo "${1#-}" | tr 'lLDUR' '\\hjkl')"

    if [ $direction == "\\" ]; then
        # count lines
        TMUX_PANES=$(tmux list-panes | wc -l)

        if [ $TMUX_PANES == 1 ]
        then
            tmux split-window -v -l 13
        else
            tmux resize-pane -Z
            tmux select-pane -D
        fi
    fi


    tmux send-keys "C-$direction"

else
    tmux select-pane "$@"
    if [ "$@" == "-l" ]; then
      tmux resize-pane -Z
    fi
fi
