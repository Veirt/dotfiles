local utils = require("utils")

return {
    "lewis6991/gitsigns.nvim",
    opt = {},
    config = function()
        utils.map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")
        utils.map("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
        utils.map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
        utils.map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
        utils.map("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>")
        utils.map("n", "<leader>sh", "<cmd>Gitsigns stage_hunk<CR>")
    end,
}
