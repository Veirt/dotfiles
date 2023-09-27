local utils = require("utils")

utils.map("n", "<leader>vt", "<cmd>TexlabBuild<CR>")

vim.cmd([[autocmd FileType tex let g:PasteImageFunction = 'g:LatexPasteImage']])
vim.cmd([[autocmd FileType markdown,tex nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>]])
