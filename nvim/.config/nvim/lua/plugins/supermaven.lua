local utils = require("utils")

return {
    "supermaven-inc/supermaven-nvim",
    config = function()
        require("supermaven-nvim").setup({
            keymaps = {
                accept_suggestion = "<C-e>",
            },
            ignore_filetypes = { "markdown" },
        })
    end,
}
