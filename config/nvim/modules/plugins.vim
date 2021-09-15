call plug#begin("~/.vim/plugged")
" Language supports
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense engine
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rafamadriz/friendly-snippets'
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
Plug 'folke/which-key.nvim' " displays a popup with possible key bindings of the command you started typing.

" Customization
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree with git indicator
Plug 'ryanoasis/vim-devicons' " Add icons to NERDTree
Plug 'kyazdani42/nvim-web-devicons' " A lua fork of vim-devicons
Plug 'romgrk/barbar.nvim' " Tabline plugin
Plug 'mhinz/vim-startify' " Code formatter

Plug 'folke/tokyonight.nvim' " Tokyo Night theme
Plug 'hoob3rt/lualine.nvim' " Blazing fast and easy to configure neovim statusline
call plug#end()
