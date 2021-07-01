set nocompatible              " be iMproved, required
filetype off                  " required

set encoding=utf-8
set relativenumber
syntax on

" PEP 8 Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Rust
au BufNewFile,BufRead *.rs
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
Plugin 'preservim/nerdtree' " NERDTree
call vundle#end()

set laststatus=2
let g:lightline = {'colorscheme': 'nord'}

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense engine
Plug 'sheerun/vim-polyglot' " Collection of language packs for Vim
Plug 'luochen1990/rainbow' " Rainbow Brackets
Plug 'tmux-plugins/vim-tmux-focus-events' " Fix focus issues vim with tmux
Plug 'ntk148v/vim-horizon' " Horizon theme
Plug 'dracula/vim', { 'as': 'dracula' } " Dracula theme
Plug 'arcticicestudio/nord-vim' " Nord theme
Plug 'rust-lang/rust.vim' " Rust support
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree git icon
Plug 'ryanoasis/vim-devicons' " NERDTree with icons
call plug#end()

colorscheme nord
let g:rainbow_active = 1 " Activating rainbow brackets

" Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:rustfmt_autosave = 1 " Rustfmt when save

" :W (capital w) to save
nnoremap :W :w<cr>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-E> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Remap for refactor
nmap <F2> <Plug>(coc-rename)
