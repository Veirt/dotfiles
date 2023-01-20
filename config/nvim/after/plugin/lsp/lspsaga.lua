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

-- diagnostic_header = { " ", " ", " ", " " },
-- code_action_icon = "",
-- code_action_keys = {
--     quit = "<Esc>",
--     exec = "<CR>",
-- },
-- code_action_lightbulb = {
--     enable = true,
--     sign = true,
--     sign_priority = 20,
--     virtual_text = false,
-- },
