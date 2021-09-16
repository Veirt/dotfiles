" NERDTree remap
nnoremap <silent> <leader>n :NERDTreeFocus<CR>
nnoremap <silent> <C-n> :NERDTree<CR>
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

let NERDTreeWinPos=1 " NERDTree right side
let NERDTreeAutoDeleteBuffer = 1 " Automatically delete the buffer of the file you just deleted with NERDTree
let NERDTreeQuitOnOpen = 1 " Automatically close NERDTree when you open a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1
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
