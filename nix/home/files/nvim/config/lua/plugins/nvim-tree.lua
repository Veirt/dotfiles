local utils = require("utils")

return {
    "kyazdani42/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup({
            disable_netrw = true,
            hijack_netrw = true,
            open_on_tab = false,
            hijack_cursor = true,
            update_cwd = true,
            hijack_directories = {
                enable = true,
                auto_open = true,
            },
            diagnostics = {
                enable = true,
                icons = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                },
            },
            update_focused_file = {
                enable = true,
                update_cwd = false,
                ignore_list = {},
            },
            filters = {
                dotfiles = false,
            },
            git = {
                enable = true,
                ignore = false,
                timeout = 500,
            },
            view = {
                width = 40,
                side = "right",
            },
        })
        utils.map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>")
    end,
}
