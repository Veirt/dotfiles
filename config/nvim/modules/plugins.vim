call plug#begin("~/.vim/plugged")
" Language supports
" Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense engine
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'rafamadriz/friendly-snippets'
Plug 'neovim/nvim-lspconfig'
Plug 'alexaandru/nvim-lspupdate'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " Fast as FUCK nvim completion.
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " 9000+ snippets

Plug 'tpope/vim-fugitive' " Vim git plugin
Plug 'kyazdani42/nvim-tree.lua' " File explorer
Plug 'christoomey/vim-tmux-navigator' " Vim tmux

" Additional features
Plug 'tpope/vim-commentary' " Comment with gcc
Plug 'windwp/nvim-autopairs' " Brackets auto pair
Plug 'nvim-lua/plenary.nvim' " Required by telescope.nvim
Plug 'nvim-telescope/telescope.nvim' " A highly extendable fuzzy finder over lists
Plug 'nvim-lua/popup.nvim' " Required by harpoon
Plug 'ThePrimeagen/harpoon' " Get you where you want with the fewest keystrokes.
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'} " Native fzf
Plug 'lewis6991/gitsigns.nvim' " Super fast git decorations
Plug 'sbdchd/neoformat' " Format code/Prettier
Plug 'editorconfig/editorconfig-vim' " EditorConfig integration with Vim
" Plug 'folke/trouble.nvim'

" Utilities
Plug 'wakatime/vim-wakatime' " WakaTime
Plug 'folke/which-key.nvim' " Displays a popup with possible key bindings of the command you started typing.
Plug 'norcalli/nvim-colorizer.lua' " A high-performance color highlighter for Neovim

" Customization
Plug 'kyazdani42/nvim-web-devicons' " A lua fork of vim-devicons
Plug 'akinsho/bufferline.nvim' " Tabline plugin
Plug 'mhinz/vim-startify' " Code formatter

Plug 'folke/tokyonight.nvim' " Tokyo Night theme
Plug 'hoob3rt/lualine.nvim' " Blazing fast and easy to configure neovim statusline
call plug#end()
