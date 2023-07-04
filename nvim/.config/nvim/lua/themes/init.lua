vim.api.nvim_command([[augroup Color]])
vim.api.nvim_command([[autocmd!]])
vim.api.nvim_command([[au ColorScheme * hi LineNr guibg=NONE ctermbg=NONE guifg=#fff]])
vim.api.nvim_command([[au ColorScheme * hi CursorLineNr guifg=#fefefe]])
vim.api.nvim_command([[au ColorScheme * hi NvimTreeNormal guibg=NONE]])
vim.api.nvim_command([[augroup END]])
vim.cmd([[
    sign define DiagnosticSignError text=  linehl= texthl=DiagnosticSignError numhl=
    sign define DiagnosticSignWarn text=  linehl= texthl=DiagnosticSignWarn numhl=
    sign define DiagnosticSignInfo text=  linehl= texthl=DiagnosticSignInfo numhl=
    sign define DiagnosticSignHint text=  linehl= texthl=DiagnosticSignHint numhl=
]])

require("themes.solarized")
