set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=utf-8
set relativenumber
syntax on

set termguicolors

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
Plugin 'preservim/nerdtree' " NERDTree
call vundle#end()
filetype plugin indent on    " required

" Plug
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense engine
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'} " mru and stuff
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'} " color highlighting

Plug 'sheerun/vim-polyglot' " Collection of language packs for Vim
Plug 'luochen1990/rainbow' " Rainbow Brackets
Plug 'tmux-plugins/vim-tmux-focus-events' " Fix focus issues vim with tmux
Plug 'ntk148v/vim-horizon' " Horizon theme
Plug 'dracula/vim', { 'as': 'dracula' } " Dracula theme
Plug 'arcticicestudio/nord-vim' " Nord theme
Plug 'rust-lang/rust.vim' " Rust support
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree git icon
Plug 'ryanoasis/vim-devicons' " NERDTree with icons
Plug 'bagrat/vim-buffet' " IDE-like Vim tabline 
Plug 'tpope/vim-commentary' " comment with gcc
Plug 'mhinz/vim-startify' " fancy start screen for vim
Plug 'ghifarit53/tokyonight-vim' " Tokyo Night theme
call plug#end()

colorscheme tokyonight
let g:rainbow_active = 1 " Activating rainbow brackets

" Lightline config
set laststatus=2
let g:lightline = {'colorscheme': 'tokyonight'}

" Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:rustfmt_autosave = 1 " Rustfmt when save

" the prefix to use for leader commands
let g:mapleader="<space>"

inoremap <silent><expr> <c-space> coc#refresh()

" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

" gi - go to implementation
nmap <silent> gi <Plug>(coc-implementation)

" gr - find references
nmap <silent> gr <Plug>(coc-references)

" gh - get hint on whatever's under the cursor
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" List errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<cr>

" list commands available in tsserver (and others)
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

" restart when tsserver gets wonky
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

" view all errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<CR>

" manage extensions
nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>

" rename the current word in the cursor
nmap <leader>cr  <Plug>(coc-rename)
nmap <leader>cf  <Plug>(coc-format-selected)
vmap <leader>cf  <Plug>(coc-format-selected)

" run code actions
vmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" NERDTree remap
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-E> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Remap for refactor
nmap <F2> <Plug>(coc-rename)

" Tabline (vim-buffet) remap
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
noremap <Leader><Tab> :Bw<CR>
noremap <Leader><S-Tab> :Bw!<CR>
noremap <C-t> :tabnew split<CR>
noremap <C-w> :q<CR>

