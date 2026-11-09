return {
    "akinsho/bufferline.nvim",
    config = function()
        require("bufferline").setup({
            options = {
                separator_style = {},
                show_buffer_icons = false,
                show_buffer_close_icons = false,
            },
        })
    end,
}
