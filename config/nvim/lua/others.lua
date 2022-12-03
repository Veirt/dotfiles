require("gitsigns").setup({
    signs = {
        untracked = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    },
})

require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        show_close_icon = false,
    },
})

require("surround").setup({ mappings_style = "surround", map_insert_mode = false, prompt = false })

require("nvim-autopairs").setup({ map_cr = true })

require("Navigator").setup()

require("presence"):setup({
    neovim_image_text = "Neovim",
    buttons = false,
    show_time = true,
    blacklist = { "*posttest*" },
    -- file_assets = {},
})
