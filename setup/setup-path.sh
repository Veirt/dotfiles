#!/usr/bin/env fish

## SETUP PATH

# cargo
set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths

# local (sometimes pip related)
set -U fish_user_paths $HOME/.local/bin $fish_user_paths

# scripts from this repo
set -U fish_user_paths $HOME/.scripts $fish_user_paths

# npm
set -U fish_user_paths $HOME/.local/share/npm/bin $fish_user_paths

# go
set -U fish_user_paths $HOME/.local/share/go/bin $fish_user_paths
