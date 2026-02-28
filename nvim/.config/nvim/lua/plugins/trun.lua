return {
    "veirt/trun.nvim",
    dependencies = { "ThePrimeagen/harpoon" },
    config = function()
        require("trun").setup()
    end,
}
