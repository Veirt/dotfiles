local utils = require("utils")

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        lazygit = {
            enabled = true,
            theme = {
                activeBorderColor = { fg = "Keyword" },
                inactiveBorderColor = { fg = "Normal" },
            },
        },
    },

    config = function()
        utils.map("n", "<leader>gg", "<cmd>lua require('snacks').lazygit()<CR>")
    end,
}
