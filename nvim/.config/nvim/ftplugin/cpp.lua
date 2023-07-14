vim.cmd([[nnoremap <C-c> :silent !foot -e bash -c "g++ "%" -o a.out; ./a.out; fish" 2> /dev/null &  <CR>]])
vim.cmd([[set indentkeys-=:]])
