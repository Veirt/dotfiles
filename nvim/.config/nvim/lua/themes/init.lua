vim.cmd([[
    augroup Color
    autocmd!
    au ColorScheme * hi LineNr guibg=NONE ctermbg=NONE guifg=#fff
    au ColorScheme * hi CursorLineNr guifg=#fefefe
    au ColorScheme * hi NvimTreeNormal guibg=NONE
    augroup END
]])

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "󰌵",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
})

require("themes.solarized")
