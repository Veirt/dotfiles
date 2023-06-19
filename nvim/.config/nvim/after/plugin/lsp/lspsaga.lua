local saga = require("lspsaga")

saga.setup({
    ui = {
        -- currently only round theme
        theme = "round",
        -- border type can be single,double,rounded,solid,shadow.
        border = "solid",
        winblend = 0,
        expand = "",
        collaspe = "",
        preview = " ",
        code_action = "",
        diagnostic = "🐞",
        incoming = " ",
        outgoing = " ",
        colors = {
            --float window normal background color
            normal_bg = "#1F1F1F",
            --title background color
            title_bg = "#afd700",
            red = "#e95678",
            magenta = "#b33076",
            orange = "#FF8700",
            yellow = "#f7bb3b",
            green = "#afd700",
            cyan = "#36d0e0",
            blue = "#61afef",
            purple = "#CBA6F7",
            white = "#d1d4cf",
            black = "#1c1c19",
        },
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
})
