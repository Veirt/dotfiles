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

require("surround").setup({ mappings_style = "surround", map_insert_mode = false, prompt = false })

require("nvim-autopairs").setup({ map_cr = true })

require("nvim-lastplace").setup({
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
    lastplace_open_folds = true,
})
