set nocompatible              " be iMproved, required
filetype off                  " required
syntax on

set encoding=utf-8
set relativenumber
set formatoptions-=cro
set termguicolors

set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed

set mouse=a                 " enable mouse click
set ttyfast                 " Speed up scrolling in Vim

" Map space to leader
map <Space> <Leader>

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix


call plug#begin('~/.vim/plugged')
" Language supports
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense engine
Plug 'sheerun/vim-polyglot' " Collection of language packs for Vim
" Plug 'neovim/nvim-lspconfig'
" Plug 'alexaandru/nvim-lspupdate'
" Plug 'nvim-lua/completion-nvim'

Plug 'tpope/vim-fugitive' " Vim git plugin
Plug 'preservim/nerdtree' " NERDTree
Plug 'christoomey/vim-tmux-navigator' " Vim tmux
Plug 'tmux-plugins/vim-tmux-focus-events' " Fix focus issues vim with tmux

" Additional features
Plug 'tpope/vim-commentary' " comment with gcc
Plug 'jiangmiao/auto-pairs' " Brackets auto pair
Plug 'luochen1990/rainbow' " Rainbow Brackets
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' } " Modern generic interactive finder and dispatcher
Plug 'folke/trouble.nvim'

" Utilities
Plug 'wakatime/vim-wakatime' " WakaTime

" Customization
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree git icon
Plug 'ryanoasis/vim-devicons' " NERDTree with icons
Plug 'kyazdani42/nvim-web-devicons' " A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
Plug 'romgrk/barbar.nvim' " Tabline plugin

" Plug 'mhinz/vim-startify' " fancy start screen for vim
Plug 'glepnir/dashboard-nvim' " Vim dashboard like startify
Plug 'arcticicestudio/nord-vim' " Nord theme
Plug 'ghifarit53/tokyonight-vim' " Tokyo Night theme
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline-themes' " Airline theme
call plug#end()

let g:coc_global_extensions = [
  \'coc-discord-rpc',
  \'coc-snippets',
  \'coc-lists',
  \'coc-highlight',
  \'coc-markdownlint',
  \'coc-rust-analyzer',
  \'coc-pyright',
  \'coc-prettier',
  \'coc-tsserver',
  \'coc-json',
  \'coc-eslint',
  \'coc-css',
  \'coc-html',
  \'coc-emmet',
  \'coc-vetur',
  \]

colorscheme tokyonight
let g:rainbow_active = 1 " Activating rainbow brackets

let NERDTreeWinPos=1 " NERDTree right side

let g:rustfmt_autosave = 1 " Rustfmt when save

" Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

source ~/.config/nvim/airline.vim
source ~/.config/nvim/remap.vim
