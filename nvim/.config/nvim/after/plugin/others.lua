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

require("gitsigns").setup()

require("surround").setup({ mappings_style = "surround", map_insert_mode = false, prompt = false })

require("nvim-autopairs").setup({ map_cr = true, disable_in_macro = true })

require("Navigator").setup()

require("presence"):setup({
    neovim_image_text = "Neovim",
    buttons = false,
    show_time = true,
    blacklist = { "%posttest", "%apl" },
})

vim.g.knap_settings = {
    texoutputext = "pdf",
    textopdf = "pdflatex -shell-escape -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
    textopdfviewerlaunch =
    "zathura --synctex-editor-command 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
    textopdfviewerrefresh = "none",
    textopdfforwardjump = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%",
}

require("fidget").setup({})

require("copilot").setup({
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
    },
})
