-- disable copilot by default
vim.cmd("Copilot disable")

require("bufferline").setup({
    options = {
        separator_style = {},
        show_buffer_icons = false,
        show_buffer_close_icons = false,
    },
})
require("harpoon").setup({ global_settings = { enter_on_sendcmd = true } })

require("nvim-surround").setup({})

require("Navigator").setup({})
require("guess-indent").setup({})

require("wildfire").setup()

require("nvim-autopairs").setup()

require("cord").setup({
    editor = {
        tooltip = "Neovim",
    },
})

require("ts-error-translator").setup()
