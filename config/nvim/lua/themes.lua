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
        bufferline = true,
        markdown = false,
        lightspeed = false,
        ts_rainbow = false,
        hop = false,
    }
}


-- vim.cmd[[colorscheme substrata]]
vim.cmd[[highlight LineNr guibg=NONE guifg=##FDEBC3]]
vim.cmd[[highlight CursorLineNr guifg=#fafafa]]
-- Hide tilde (~)
-- And set background to none
-- vim.cmd[[hi EndOfBuffer guibg=NONE guifg=#191C25]]
vim.cmd[[colorscheme catppuccino]]

-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_transparent = true
-- vim.cmd[[colorscheme tokyonight]]

vim.cmd[[sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=]]
vim.cmd[[sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=]]
vim.cmd[[sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=]]
vim.cmd[[sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=]]
