nnoremap <leader>er <cmd>Trouble lsp_document_diagnostics<CR>
nnoremap <silent><F2> <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <leader>eR <cmd>Trouble lsp_workspace_diagnostics<CR>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <leader>cs <cmd>Telescope lsp_document_symbols<CR>
nnoremap gr <cmd>Trouble lsp_references<CR>
