local utils = require("utils")

utils.map("n", "<leader>vt", "<cmd>TexlabBuild<CR>")

vim.cmd([[
function! g:LatexPasteImage(relpath)
    execute "normal! i\\includegraphics[width=0.95\\textwidth]{" . a:relpath . "}\r\\caption{I"
    let ipos = getcurpos()
    execute "normal! a" . "mage}"
    call setpos('.', ipos)
    execute "normal! ve\<C-g>"
endfunction
]])

vim.cmd([[autocmd FileType tex let g:PasteImageFunction = 'g:LatexPasteImage']])
vim.cmd([[autocmd FileType markdown,tex nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>]])
