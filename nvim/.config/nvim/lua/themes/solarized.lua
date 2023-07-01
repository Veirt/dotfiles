vim.g.solarized_italics = 1
vim.g.solarized_termtrans = 1

require("neosolarized").setup({
    comment_italics = true,
    background_set = false,
})
vim.cmd([[hi CursorLine guibg=#1F1F1F]])
vim.cmd([[hi PMenu guibg=#1F1F1F]])
