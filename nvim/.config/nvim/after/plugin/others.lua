-- require("bufferline").setup({
--     highlights = {
--         buffer_selected = {
--             bold = true,
--             italic = false,
--         },
--     },
--     options = {
--         diagnostics = "nvim_lsp",
--         show_buffer_close_icons = false,
--         show_close_icon = false,
--         indicator = {
--             style = "icon",
--         },
--     },
-- })

require("surround").setup({ mappings_style = "surround", map_insert_mode = false, prompt = false })
require("nvim-autopairs").setup({ map_cr = true, disable_in_macro = true })
require("Navigator").setup({})
require("guess-indent").setup()
require("copilot").setup({
    filetypes = {
        cpp = true,
        ["*"] = false,
    },
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
