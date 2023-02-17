local lsp = require("lsp-zero")
lsp.configure("racket_langserver")

vim.api.nvim_command([[augroup AutoPairScheme]])
vim.api.nvim_command(
    [[autocmd! FileType scheme lua require("nvim-autopairs").setup({ map_cr = true, disable_in_macro = true, enable_check_bracket_line = false })]]
)
vim.api.nvim_command([[augroup END]])
