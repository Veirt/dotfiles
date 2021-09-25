call plug#begin("~/.vim/plugged")
" Language supports
" Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense engine
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'alexaandru/nvim-lspupdate'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " Fast as FUCK nvim completion.
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " 9000+ snippets

" Plug 'tpope/vim-fugitive' " Vim git plugin
Plug 'kyazdani42/nvim-tree.lua' " File explorer
Plug 'christoomey/vim-tmux-navigator' " Vim tmux

" Additional features
Plug 'tpope/vim-commentary' " Comment with gcc
Plug 'windwp/nvim-autopairs' " Brackets auto pair
Plug 'windwp/nvim-ts-autotag' " Use treesitter to autoclose and autorename html tag
Plug 'nvim-lua/plenary.nvim' " Required by telescope.nvim
Plug 'nvim-telescope/telescope.nvim' " A highly extendable fuzzy finder over lists
Plug 'nvim-lua/popup.nvim' " Required by harpoon
Plug 'ThePrimeagen/harpoon' " Get you where you want with the fewest keystrokes.
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'} " Native fzf
Plug 'lewis6991/gitsigns.nvim' " Super fast git decorations
Plug 'sbdchd/neoformat' " Format code/Prettier
Plug 'editorconfig/editorconfig-vim' " EditorConfig integration with Vim
Plug 'folke/trouble.nvim'
Plug 'glepnir/lspsaga.nvim' " LSP plugin with highly performant UI
Plug 'tpope/vim-surround' " Easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-sleuth' " Automatically adjusts indent

" Utilities
" Plug 'folke/which-key.nvim' " Displays a popup with possible key bindings of the command you started typing.
Plug 'norcalli/nvim-colorizer.lua' " A high-performance color highlighter for Neovim
Plug 'lervag/vimtex', {'for': 'latex'} " Syntax plugin for LaTeX files.
Plug 'kdheepak/lazygit.nvim' " Call lazygit within neovim
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " Preview markdown on your modern browser
Plug 'tweekmonster/startuptime.vim' " Measure startup
" Plug 'vim-test/vim-test', {'for': ['python', 'javascript', 'typescript', 'rust']}
" Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins', 'for': ['python', 'javascript', 'typescript', 'rust'] }
Plug 'andweeb/presence.nvim'

" Customization
Plug 'kyazdani42/nvim-web-devicons' " A lua fork of vim-devicons
Plug 'akinsho/bufferline.nvim' " Tabline plugin
Plug 'glepnir/dashboard-nvim' " Vim dashboard
Plug 'folke/tokyonight.nvim' " Tokyo Night theme
" Plug 'Pocco81/Catppuccino.nvim'
" Plug 'norcalli/nvim-base16.lua' " Programmatic lua library for setting base16 themes in Neovim.
Plug 'kvrohit/substrata.nvim'
Plug 'famiu/feline.nvim' " A minimal, stylish and customizable statusline for Neovim written in Lua

" Games
" Plug 'ThePrimeagen/vim-be-good'
call plug#end()
