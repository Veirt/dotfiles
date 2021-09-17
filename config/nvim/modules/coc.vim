let g:coc_global_extensions = [
  \'coc-discord-rpc',
  \]

" let g:coc_global_extensions = [
"   \'coc-discord-rpc',
"   \'coc-snippets',
"   \'coc-lists',
"   \'coc-highlight',
"   \'coc-markdownlint',
"   \'coc-rust-analyzer',
"   \'coc-sql',
"   \'coc-pyright',
"   \'coc-tsserver',
"   \'coc-json',
"   \'coc-eslint',
"   \'coc-css',
"   \'coc-phpls',
"   \'coc-html-css-support',
"   \'coc-emmet',
"   \'@yaegassy/coc-volar',
"   \]

" " Ctrl + space to toggle autocompletion
" inoremap <silent><expr> <c-space> coc#refresh()

" " Autocomplete with tab
" inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"

" " gd - go to definition of word under cursor
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)

" " gr - find references
" nmap <silent> gr <Plug>(coc-references)

" " gh - get hint on whatever's under the cursor
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" nnoremap <silent> gh :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if &filetype == 'vim'
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction


" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
" nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" " List errors
" nnoremap <silent> <leader>er  :<C-u>CocList diagnostics<cr>

" " list commands available in tsserver (and others)
" nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

" " restart when tsserver gets wonky
" nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

" " manage extensions
" nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>

" " rename the current word in the cursor
" nmap <F2> <Plug>(coc-rename)
" nmap <leader>cf  <Plug>(coc-format-selected)
" vmap <leader>cf  <Plug>(coc-format-selected)

" " run code actions
" vmap <silent> <leader>ca  <Plug>(coc-codeaction-selected)
" nmap <silent> <leader>ca  <Plug>(coc-codeaction-selected)

