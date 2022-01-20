require("refactoring").setup({})

require("colorizer").setup()

require("gitsigns").setup({})

-- require('which-key').setup {}

require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        show_close_icon = false,
    },
})

require("presence"):setup({
    buttons = false,
})

require("persistence").setup({})

require("surround").setup({ mappings_style = "surround", map_insert_mode = false })

require("nvim-autopairs").setup({ map_cr = true })
