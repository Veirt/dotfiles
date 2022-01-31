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

local catppuccin = require("catppuccin")

-- -- configure it
-- catppuccin.setup({
--     transparent_background = false,
--     styles = {
--         comments = "italic",
--         functions = "italic,bold",
--         keywords = "bold",
--         strings = "NONE",
--     },
--     integrations = {
--         treesitter = true,
--         native_lsp = {
--             enabled = true,
--             virtual_text = {
--                 errors = "italic",
--                 hints = "italic",
--                 warnings = "italic",
--                 information = "italic",
--             },
--             underlines = {
--                 errors = "undercurl",
--                 hints = "undercurl",
--                 warnings = "undercurl",
--                 information = "undercurl",
--             },
--         },
--         cmp = true,
--         lsp_saga = true,
--         gitsigns = true,
--         telescope = true,
--         nvimtree = {
--             enabled = true,
--             show_root = false,
--             transparent_panel = true,
--         },
--         which_key = false,
--         bufferline = true,
--         markdown = true,
--         lightspeed = false,
--         ts_rainbow = true,
--     },
-- })

-- nightfox.setup({
--     fox = "nordfox", -- change the colorscheme to use nordfox
--     transparent = true, -- Disable setting the background color
--     terminal_colors = true, -- Configure the colors used when opening :terminal
--     styles = {
--         comments = "italic", -- change style of comments to be italic
--         keywords = "bold", -- change style of keywords to be bold
--         functions = "italic,bold", -- styles can be a comma separated list
--     },
--     inverse = {
--         match_paren = true, -- inverse the highlighting of match_parens
--     },
-- })
-- nightfox.load()

vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_background = "hard"
-- vim.g.gruvbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_diagnostic_line_highlight = 1
vim.cmd([[colorscheme gruvbox-material]])
