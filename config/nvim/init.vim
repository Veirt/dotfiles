set nocompatible              " be iMproved, required
filetype off                  " required
syntax on

set encoding=utf-8
set relativenumber
set nu
set formatoptions-=cro
set termguicolors
set noerrorbells
set nowrap
set scrolloff=8
set incsearch
set signcolumn=yes

set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed

set mouse=a                 " enable mouse click
set ttyfast                 " speed up scrolling in Vim
set hidden                  " change buffer without save

" Map space to leader
map <Space> <Leader>

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
Plug 'tpope/vim-commentary' " Comment with gcc
Plug 'jiangmiao/auto-pairs' " Brackets auto pair
Plug 'nvim-lua/plenary.nvim' " Required by telescope.nvim
Plug 'nvim-telescope/telescope.nvim' " A highly extendable fuzzy finder over lists
" Plug 'folke/trouble.nvim'

" Utilities
Plug 'wakatime/vim-wakatime' " WakaTime

" Customization
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree git icon
Plug 'ryanoasis/vim-devicons' " NERDTree with icons
Plug 'kyazdani42/nvim-web-devicons' " A lua fork of vim-devicons
Plug 'romgrk/barbar.nvim' " Tabline plugin

Plug 'glepnir/dashboard-nvim' " Vim dashboard like startify
Plug 'arcticicestudio/nord-vim' " Nord theme
Plug 'ghifarit53/tokyonight-vim' " Tokyo Night theme
Plug 'hoob3rt/lualine.nvim' " Blazing fast and easy to configure neovim statusline
call plug#end()

lua << EOF
require('lualine').setup {
  options = {theme = 'nightfly'}
}
EOF

let g:coc_global_extensions = [
  \'coc-discord-rpc',
  \'coc-snippets',
  \'coc-lists',
  \'coc-highlight',
  \'coc-markdownlint',
  \'coc-rust-analyzer',
  \'coc-sql',
  \'coc-pyright',
  \'coc-prettier',
  \'coc-tsserver',
  \'coc-json',
  \'coc-eslint',
  \'coc-css',
  \'coc-html-css-support',
  \'coc-emmet',
  \'@yaegassy/coc-volar',
  \]

colorscheme tokyonight

let NERDTreeWinPos=1 " NERDTree right side

let g:rustfmt_autosave = 1 " Rustfmt when save
command! -nargs=0 Prettier :CocCommand prettier.formatFile " Prettier

let g:dashboard_default_executive ='telescope'

source ~/.config/nvim/remap.vim
