local saga = require("lspsaga")

saga.init_lsp_saga({
    diagnostic_header = { " ", " ", " ", " " },
    code_action_icon = "",
    code_action_keys = {
        quit = "<Esc>",
        exec = "<CR>",
    },
    code_action_lightbulb = {
        enable = true,
        sign = true,
        sign_priority = 20,
        virtual_text = false,
    },
})
