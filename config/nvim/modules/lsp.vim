nnoremap <leader>er <cmd>Telescope lsp_document_diagnostics<CR>
nnoremap <leader>el <cmd>Lspsaga show_line_diagnostics<CR>
vnoremap <leader>el <cmd>Lspsaga show_cursor_diagnostics<CR>
nnoremap <leader>eR <cmd>Telescope lsp_workspace_diagnostics<CR>

nnoremap <silent><F2> <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <leader>cs <cmd>Telescope lsp_document_symbols<CR>
nnoremap gr <cmd>Lspsaga lsp_finder<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

nnoremap <leader>lr <cmd>LspRestart<CR>
