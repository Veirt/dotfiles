vim.cmd([[
    augroup Color
    autocmd!
    au ColorScheme * hi LineNr guibg=NONE ctermbg=NONE guifg=#fff
    au ColorScheme * hi CursorLineNr guifg=#fefefe
    au ColorScheme * hi NvimTreeNormal guibg=NONE
    augroup END
]])
vim.cmd([[
    sign define DiagnosticSignError text=  linehl= texthl=DiagnosticSignError numhl=
    sign define DiagnosticSignWarn text=  linehl= texthl=DiagnosticSignWarn numhl=
    sign define DiagnosticSignInfo text=  linehl= texthl=DiagnosticSignInfo numhl=
    sign define DiagnosticSignHint text=  linehl= texthl=DiagnosticSignHint numhl=
]])

require("themes.solarized")
