set nocompatible              " be iMproved, required
filetype off                  " required
syntax on

set encoding=utf-8
set relativenumber
set termguicolors

set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed

set mouse=a                 " enable mouse click
set ttyfast                 " Speed up scrolling in Vim

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense engine
Plug 'sheerun/vim-polyglot' " Collection of language packs for Vim
Plug 'jiangmiao/auto-pairs' " Brackets auto pair
Plug 'tpope/vim-fugitive' " Vim git plugin
Plug 'christoomey/vim-tmux-navigator' " Vim tmux
Plug 'wakatime/vim-wakatime' " WakaTime
Plug 'mattn/emmet-vim' " HTML emmet
Plug 'preservim/nerdtree' " NERDTree
Plug 'luochen1990/rainbow' " Rainbow Brackets
Plug 'tmux-plugins/vim-tmux-focus-events' " Fix focus issues vim with tmux
Plug 'arcticicestudio/nord-vim' " Nord theme
Plug 'rust-lang/rust.vim' " Rust support
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree git icon
Plug 'ryanoasis/vim-devicons' " NERDTree with icons
Plug 'tpope/vim-commentary' " comment with gcc
Plug 'mhinz/vim-startify' " fancy start screen for vim
Plug 'ghifarit53/tokyonight-vim' " Tokyo Night theme
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline-themes' " Airline theme
call plug#end()

let g:coc_global_extensions = [
  \'coc-snippets',
  \'coc-prettier',
  \'coc-tsserver',
  \'coc-python',
  \'coc-json',
  \'coc-eslint',
  \'coc-css',
  \'coc-lists',
  \'coc-highlight',
  \'coc-discord-rpc',
  \'coc-rust-analyzer'
  \]

colorscheme tokyonight
let g:rainbow_active = 1 " Activating rainbow brackets

" vim-airline config
function! AirlineInit()
  let g:airline_section_z = ""
endfunction
autocmd VimEnter * call AirlineInit()

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
nmap <F2> <Plug>(coc-rename)
nmap <leader>cf  <Plug>(coc-format-selected)
vmap <leader>cf  <Plug>(coc-format-selected)

" run code actions
vmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" NERDTree remap
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" move line or visually selected block - alt+j/k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

