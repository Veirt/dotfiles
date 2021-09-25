let g:coq_settings = {
    \ 'auto_start': 'shut-up',
    \ 'keymap.bigger_preview': v:null,
    \ 'keymap.pre_select': v:true,
    \ 'keymap.recommended': v:false,
    \ 'display.ghost_text.enabled': v:false
    \ }

ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
ino <silent><expr> <Tab>   pumvisible() ? (complete_info().selected == -1 ? "\<C-e><Tab>" : "\<C-y>") : "\<Tab>"
ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"

