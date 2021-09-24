-- require('catppuccino').setup {
--     colorscheme = "dark_catppuccino",
--     transparency = false,
--     term_colors = false,
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
--                 errors = "underline",
--                 hints = "underline",
--                 warnings = "underline",
--                 information = "underline",
--             }
--         },
--         lsp_trouble = true,
--         lsp_saga = false,
--         gitsigns = true,
--         telescope = true,
--         nvimtree = {
--             enabled = true,
--             show_root = true,
--         },
--         which_key = true,
--         dashboard = true,
--         bufferline = true,
--         markdown = false,
--         lightspeed = false,
--         ts_rainbow = false,
--         hop = false,
--     }
-- }

-- local base16 = require 'base16'
-- base16(base16.themes["tomorrow-night"], true)

-- vim.cmd[[colorscheme catppuccino]]

-- vim.g.tokyonight_style = "night"
-- vim.cmd[[colorscheme tokyonight]]

-- vim.cmd[[colorscheme falcon]]
vim.cmd[[colorscheme substrata]]

-- Hide tilde (~)
vim.cmd[[hi EndOfBuffer guifg=#191C25]]

-- require("github-theme").setup({
--   theme_style = "dark",
--   -- other config
-- })
