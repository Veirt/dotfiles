local g = vim.g

g.nvim_tree_icons = {
    default = "",
    git = {
        unstaged = "U",
        staged = "S",
        unmerged = "",
        renamed = "R",
        untracked = "*",
        deleted = "D",
        ignored = "◌",
    },
}

require("nvim-tree").setup({
    nvim_tree_indent_markers = 1,
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    auto_close = false,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    update_to_buf_dir = {
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
    system_open = {
        cmd = nil,
        args = {},
    },
    filters = {
        dotfiles = false,
        custom = { ".git", "node_modules", ".cache", "__pycache__", "vendor" },
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
    view = {
        width = 30,
        height = 30,
        hide_root_folder = true,
        side = "left",
        auto_resize = true,
        mappings = {
            custom_only = false,
            list = {},
        },
        number = false,
        relativenumber = false,
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
})
