set encoding=utf-8
set fileencoding=utf-8
set relativenumber
set nu
set termguicolors
set noerrorbells
set nowrap
set scrolloff=8
set incsearch
set signcolumn=yes
set shell=/usr/bin/fish

set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set smartindent
set autoindent

set noshowmode
set mouse=a                 " enable mouse click
set ttyfast                 " speed up scrolling in Vim
set hidden                  " change buffer without save

set noswapfile
set nobackup
set nowritebackup
set updatetime=50
set shortmess+=c

cmap w!! w !sudo tee %

command! W write
command! Q quit

" Map space to leader
map <Space> <Leader>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
  augroup END
