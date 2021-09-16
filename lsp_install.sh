#!/usr/bin/env bash

mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'

echo "Installing language servers..."
npm install -g vim-language-server \
                    dockerfile-language-server-nodejs \
                    typescript typescript-language-server \
                    intelephense \
                    @tailwindcss/language-server \
                    @volar/server \
                    vscode-langservers-extracted

yarn global add yaml-language-server

go install github.com/lighttiger2505/sqls@latest
