call plug#begin("~/.vim/plugged")
" Language supports
" Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense engine
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'alexaandru/nvim-lspupdate'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'jwalton512/vim-blade' " uh
Plug 'posva/vim-vue'

" Plug 'tpope/vim-fugitive' " Vim git plugin
Plug 'kyazdani42/nvim-tree.lua' " File explorer
Plug 'christoomey/vim-tmux-navigator' " Vim tmux

" Additional features
Plug 'tomtom/tcomment_vim' " Comment with gcc
" Plug 'windwp/nvim-autopairs' " Brackets auto pair
Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-ts-autotag' " Use treesitter to autoclose and autorename html tag
Plug 'nvim-lua/plenary.nvim' " Required by telescope.nvim
Plug 'nvim-telescope/telescope.nvim' " A highly extendable fuzzy finder over lists
Plug 'nvim-lua/popup.nvim' " Required by harpoon
Plug 'ThePrimeagen/harpoon' " Get you where you want with the fewest keystrokes.
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'} " Native fzf
Plug 'lewis6991/gitsigns.nvim' " Super fast git decorations
Plug 'sbdchd/neoformat' " Format code/Prettier
Plug 'editorconfig/editorconfig-vim' " EditorConfig integration with Vim
Plug 'tami5/lspsaga.nvim' " LSP plugin with highly performant UI
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'tpope/vim-surround' " Easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-sleuth' " Automatically adjusts indent
Plug 'rmagatti/auto-session'

" Utilities
" Plug 'folke/which-key.nvim' " Displays a popup with possible key bindings of the command you started typing.
Plug 'norcalli/nvim-colorizer.lua' " A high-performance color highlighter for Neovim
Plug 'lervag/vimtex', {'for': 'latex'} " Syntax plugin for LaTeX files.
Plug 'kdheepak/lazygit.nvim' " Call lazygit within neovim
Plug 'tweekmonster/startuptime.vim' " Measure startup
" Plug 'vim-test/vim-test', {'for': ['python', 'javascript', 'typescript', 'rust']}
" Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins', 'for': ['python', 'javascript', 'typescript', 'rust'] }
Plug 'andweeb/presence.nvim'

" Customization
Plug 'kyazdani42/nvim-web-devicons' " A lua fork of vim-devicons
Plug 'onsails/lspkind-nvim' " vscode-like pictograms
Plug 'akinsho/bufferline.nvim' " Tabline plugin
Plug 'glepnir/dashboard-nvim' " Vim dashboard
" Plug 'folke/tokyonight.nvim' " Tokyo Night theme
Plug 'Pocco81/Catppuccino.nvim'
" Plug 'norcalli/nvim-base16.lua' " Programmatic lua library for setting base16 themes in Neovim.
" Plug 'kvrohit/substrata.nvim'
Plug 'famiu/feline.nvim' " A minimal, stylish and customizable statusline for Neovim written in Lua

" Games
" Plug 'ThePrimeagen/vim-be-good'
call plug#end()
