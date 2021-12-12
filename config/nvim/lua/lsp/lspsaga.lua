local saga = require("lspsaga")

saga.init_lsp_saga({
    use_saga_diagnostic_sign = true,
    -- diagnostic sign
    error_sign = "",
    warn_sign = "",
    hint_sign = "",
    infor_sign = "",
    diagnostic_header_icon = "   ",
    -- code action title icon
    code_action_icon = " ",
    code_action_keys = {
        quit = "<Esc>",
        exec = "<CR>",
    },
    code_action_prompt = {
        virtual_text = false,
    },
})
