vim.g.solarized_italics = 1
vim.g.solarized_termtrans = 1

require("neosolarized").setup({
    comment_italics = true,
    background_set = false,
})
vim.cmd([[colorscheme neosolarized]])
vim.cmd([[hi CursorLine guibg=#1F1F1F]])
vim.cmd([[hi PMenu guibg=#1F1F1F]])
vim.cmd([[hi statusline guibg=#e6eaed ctermfg=8 guifg=#151515 ctermbg=15 ]])
