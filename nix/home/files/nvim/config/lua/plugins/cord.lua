return {
    "vyfor/cord.nvim",
    build = ":Cord update",
    event = "VeryLazy",
    config = function()
        require("cord").setup({
            editor = {
                tooltip = "Neovim",
            },
            text = {
                workspace = function(opts)
                    local blacklist = {}

                    local is_blacklisted = function(opts)
                        return vim.tbl_contains(blacklist, opts.workspace)
                    end
                    return is_blacklisted(opts) and "In a secret workspace" or ("Working on " .. opts.workspace)
                end,
            },
        })
    end,
}
