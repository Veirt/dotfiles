set nocompatible              " be iMproved, required
filetype off                  " required

set encoding=utf-8
set relativenumber
syntax on

"PEP 8 Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'jiangmiao/auto-pairs' " Brackets auto pair
Plugin 'tpope/vim-fugitive' " Vim git plugin
Plugin 'itchyny/lightline.vim' " Lightline
Plugin 'christoomey/vim-tmux-navigator' " Vim tmux
Plugin 'wakatime/vim-wakatime' " WakaTime
Plugin 'mattn/emmet-vim'
Plugin 'connorholyday/vim-snazzy' " Snazzy theme
call vundle#end()

filetype plugin indent on    " required
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'horizon',
      \ }

" Plug
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense engine
Plug 'sheerun/vim-polyglot' " Collection of language packs for Vim
Plug 'luochen1990/rainbow' " Rainbow Brackets
Plug 'tmux-plugins/vim-tmux-focus-events' " Fix focus issues vim with tmux
Plug 'ntk148v/vim-horizon' " Horizon theme
call plug#end()

colorscheme horizon
let g:rainbow_active = 1 " Activating rainbow brackets

" Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

