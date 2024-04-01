require("bufferline").setup({
    options = {
        separator_style = {},
        show_buffer_icons = false,
        show_buffer_close_icons = false,
    },
})
require("harpoon").setup({ global_settings = { enter_on_sendcmd = true } })

require("surround").setup({ mappings_style = "surround", map_insert_mode = false, prompt = false })

require("Navigator").setup()
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
            accept = "<C-e>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
    },
})

require("wildfire").setup()
