require('catppuccino').setup {
    colorscheme = "soft_manilo",
    transparency = true,
    term_colors = true,
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = "italic",
                hints = "italic",
                warnings = "italic",
                information = "italic",
            },
            underlines = {
                errors = "underline",
                hints = "underline",
                warnings = "underline",
                information = "underline",
            }
        },
        lsp_trouble = true,
        lsp_saga = true,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = false,
            show_root = true,
        },
        which_key = true,
        dashboard = true,
        bufferline = true,
        markdown = false,
        lightspeed = false,
        ts_rainbow = false,
        hop = false,
    }
}

-- local base16 = require 'base16'
-- base16(base16.themes["tomorrow-night"], true)

-- vim.cmd[[colorscheme falcon]]
-- vim.cmd[[colorscheme substrata]]

vim.cmd[[colorscheme catppuccino]]
vim.cmd[[highlight LineNr guifg=##FDEBC3]]
vim.cmd[[highlight CursorLineNr guifg=#fafafa]]

-- vim.g.tokyonight_style = "night"
-- vim.cmd[[colorscheme tokyonight]]


-- Hide tilde (~)
-- vim.cmd[[hi EndOfBuffer guifg=#191C25]]

-- require("github-theme").setup({
--   theme_style = "dark",
--   -- other config
-- })
