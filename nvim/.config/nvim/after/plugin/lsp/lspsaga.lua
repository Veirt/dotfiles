local saga = require("lspsaga")

saga.setup({
    ui = {
        code_action = "",
    },
    code_action = {
        num_shortcut = true,
        keys = {
            quit = "<ESC>",
            exec = "<CR>",
        },
    },
    lightbulb = {
        enable = true,
        enable_in_insert = true,
        sign = true,
        sign_priority = 40,
        virtual_text = false,
    },
    symbol_in_winbar = {
        enable = false,
        separator = " ",
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
    },
    implement = {
        enable = false,
    },
})
