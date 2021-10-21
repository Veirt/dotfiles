#!/usr/bin/env bash
set -e

cmd="$(tmux display -p '#{pane_current_command}')"
cmd="$(basename "$cmd" | tr A-Z a-z)"

# if in nvim
if [ "${cmd}" = "nvim" ]; then
    direction="$(echo "${1#-}" | tr 'lLDUR' '\\hjkl')"

    # if Ctrl-\
    if [ $direction == "\\" ]; then
        # check tmux panes count
        TMUX_PANES=$(tmux list-panes | wc -l)

        if [ $TMUX_PANES == 1 ]; then
            tmux split-window -v -l 11 -c "#{pane_current_path}"
        else
            tmux select-pane -D
        fi

    else
        tmux send-keys "C-$direction"
    fi

else
    #if not in nvim
    if [ $@ == "-l" ]; then
        tmux select-pane -U
        tmux resize-pane -Z
    else
        tmux select-pane "$@"
    fi

fi
