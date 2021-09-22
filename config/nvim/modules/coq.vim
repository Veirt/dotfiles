let g:coq_settings = {
    \ 'auto_start': 'shut-up',
    \ 'keymap.bigger_preview': v:null,
    \ 'keymap.recommended': v:false,
    \ 'display.ghost_text.enabled': v:false
    \ }

ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
ino <silent><expr> <Tab>   pumvisible() ? (complete_info().selected == -1 ? "\<C-n><C-y>" : "\<C-y>") : "\<Tab>"
ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
