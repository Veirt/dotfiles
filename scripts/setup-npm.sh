#!/usr/bin/env bash

# Script to fix npm package installation globally
# http://npm.github.io/installation-setup-docs/installing/a-note-on-permissions.html

PREFIX=$(npm config get prefix)

if [ $PREFIX == '/usr/local' ]; then
     sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

elif [[ $PREFIX == "${HOME}/.npm-global" ]]; then
    echo "You have already set up npm."
    exit 1
else
     mkdir ~/.npm-global
     npm config set prefix '~/.npm-global'
     echo 'export PATH=~/.npm-global/bin:$PATH' >> $HOME/.profile
     echo 'export PATH=~/.npm-global/bin:$PATH' >> $HOME/.zprofile
fi
