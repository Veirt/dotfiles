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

vim.g.tokyonight_style = "night"

-- vim.cmd[[colorscheme catppuccino]]
vim.cmd[[colorscheme tokyonight]]
