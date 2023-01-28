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
})

vim.g.knap_settings = {
    texoutputext = "pdf",
    textopdf = "pdflatex -shell-escape -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
    textopdfviewerlaunch = "zathura %outputfile%",
    textopdfviewerrefresh = "kill -HUP %pid%",
}

require("fidget").setup({})
