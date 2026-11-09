local utils = require("utils")

return {
    "numToStr/Navigator.nvim",
    config = function()
        require("Navigator").setup({})
        utils.map("n", "<C-h>", "<cmd>lua require('Navigator').left()<CR>")
        utils.map("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>")
        utils.map("n", "<C-l>", "<cmd>lua require('Navigator').right()<CR>")
        utils.map("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>")
    end,
}
