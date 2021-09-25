nnoremap <leader>er <cmd>Trouble lsp_document_diagnostics<CR>
nnoremap <silent><F2> <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <leader>eR <cmd>Trouble lsp_workspace_diagnostics<CR>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <leader>cs <cmd>Telescope lsp_document_symbols<CR>
nnoremap gr <cmd>Trouble lsp_references<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

" nnoremap <silent> gh <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" " scroll down hover doc or scroll in definition preview
" nnoremap <silent> <leader>j <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" " scroll up hover doc
" nnoremap <silent> <leader>k <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
