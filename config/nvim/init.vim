command! W write
command! Q quit

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
set formatoptions-=cro

set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed

set noshowmode
set mouse=a                 " enable mouse click
set ttyfast                 " speed up scrolling in Vim
set hidden                  " change buffer without save

set nobackup
set nowritebackup
set updatetime=300
set timeoutlen=500

cmap w!! w !sudo tee %

" Map space to leader
map <Space> <Leader>

call plug#begin('~/.vim/plugged')
" Language supports
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense engine
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'neovim/nvim-lspconfig'
" Plug 'alexaandru/nvim-lspupdate'
" Plug 'nvim-lua/completion-nvim'

Plug 'tpope/vim-fugitive' " Vim git plugin
Plug 'preservim/nerdtree' " NERDTree file explorer
Plug 'christoomey/vim-tmux-navigator' " Vim tmux

" Additional features
Plug 'tpope/vim-commentary' " Comment with gcc
Plug 'jiangmiao/auto-pairs' " Brackets auto pair
Plug 'nvim-lua/plenary.nvim' " Required by telescope.nvim
Plug 'nvim-telescope/telescope.nvim' " A highly extendable fuzzy finder over lists
Plug 'nvim-telescope/telescope-project.nvim' " An extension for telescope.nvim that allows you to switch between projects.
Plug 'sbdchd/neoformat' " Format code/Prettier
" Plug 'folke/trouble.nvim'

" Utilities
Plug 'wakatime/vim-wakatime' " WakaTime

" Customization
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree with git indicator
Plug 'ryanoasis/vim-devicons' " Add icons to NERDTree
Plug 'kyazdani42/nvim-web-devicons' " A lua fork of vim-devicons
Plug 'romgrk/barbar.nvim' " Tabline plugin
Plug 'mhinz/vim-startify' " Code formatter

Plug 'ghifarit53/tokyonight-vim' " Tokyo Night theme
Plug 'hoob3rt/lualine.nvim' " Blazing fast and easy to configure neovim statusline
call plug#end()

let g:coc_global_extensions = [
  \'coc-discord-rpc',
  \'coc-snippets',
  \'coc-lists',
  \'coc-highlight',
  \'coc-markdownlint',
  \'coc-rust-analyzer',
  \'coc-sql',
  \'coc-pyright',
  \'coc-tsserver',
  \'coc-json',
  \'coc-eslint',
  \'coc-css',
  \'coc-phpls',
  \'coc-html-css-support',
  \'coc-emmet',
  \'@yaegassy/coc-volar',
  \]

let g:tokyonight_enable_italic = 1
colorscheme tokyonight

" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

let NERDTreeWinPos=1 " NERDTree right side
let NERDTreeAutoDeleteBuffer = 1 " Automatically delete the buffer of the file you just deleted with NERDTree
let NERDTreeQuitOnOpen = 1 " Automatically close NERDTree when you open a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeGitStatusUseNerdFonts = 1 
let g:NERDTreeGitStatusConcealBrackets = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'M',
                \ 'Staged'    :'S',
                \ 'Untracked' :'U',
                \ 'Renamed'   :'R',
                \ 'Deleted'   :'D',
                \ 'Ignored'   :'I',
                \ 'Clean'     :'C',
                \ 'Unknown'   :'?',
                \ }


source ~/.config/nvim/remap.vim
luafile ~/.config/nvim/ext.lua
