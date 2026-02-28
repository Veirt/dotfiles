return {
    "jinzhongjia/LspUI.nvim",
    branch = "main",
    config = function()
        require("LspUI").setup({
            lightbulb = {
                enable = false,
                icon = "󰌵",
            },
        })
    end,
}
