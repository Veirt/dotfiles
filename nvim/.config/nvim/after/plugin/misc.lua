vim.g.buftabline_indicators = true

require("harpoon").setup({ global_settings = { enter_on_sendcmd = true } })

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
            accept = "<C-e>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
    },
})
