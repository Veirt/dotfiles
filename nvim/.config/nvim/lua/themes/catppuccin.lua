local catppuccin = require("catppuccin")

catppuccin.setup({
    transparent_background = true,
    styles = {
        comments = "italic",
        functions = "italic,bold",
        keywords = "bold",
        strings = "NONE",
    },
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
                errors = "undercurl",
                hints = "undercurl",
                warnings = "undercurl",
                information = "undercurl",
            },
        },
        cmp = true,
        lsp_saga = true,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = true,
            show_root = false,
            transparent_panel = true,
        },
        which_key = false,
        bufferline = true,
        markdown = true,
        lightspeed = false,
        ts_rainbow = true,
    },
})

vim.g.catppuccin_flavour = "mocha"
vim.cmd([[colorscheme catppuccin]])
