local nightfox = require("nightfox")

nightfox.setup({
    options = {
        transparent = true,
        terminal_colors = true,
        styles = {
            comments = "italic",
            keywords = "bold",
            functions = "italic,bold",
        },
        inverse = {
            match_paren = false,
        },
    },
})

vim.cmd([[colorscheme nordfox]])
vim.cmd([[hi CursorLine guibg=#1F1F1F]])
vim.cmd([[hi PMenu guibg=#1F1F1F]])
