local nightfox = require("nightfox")

vim.api.nvim_command([[augroup Color]])
vim.api.nvim_command([[autocmd!]])
vim.api.nvim_command([[au ColorScheme * hi LineNr guibg=NONE ctermbg=NONE guifg=#fff]])
vim.api.nvim_command([[au ColorScheme * hi CursorLineNr guifg=#fefefe]])
vim.api.nvim_command([[au ColorScheme * hi NvimTreeNormal guibg=NONE]])
vim.api.nvim_command([[augroup END]])

-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_transparent_sidebar = true

nightfox.setup({
    fox = "nordfox", -- change the colorscheme to use nordfox
    transparent = true, -- Disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening :terminal
    styles = {
        comments = "italic", -- change style of comments to be italic
        keywords = "bold", -- change style of keywords to be bold
        functions = "italic,bold", -- styles can be a comma separated list
    },
    inverse = {
        match_paren = true, -- inverse the highlighting of match_parens
    },
})
nightfox.load()
