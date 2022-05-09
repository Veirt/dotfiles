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
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    open_on_tab = false,
    hijack_cursor = false,
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
        update_cwd = true,
        ignore_list = {},
    },
    system_open = {
        cmd = nil,
        args = {},
    },
    filters = {
        dotfiles = false,
        custom = { ".git", ".cache", "__pycache__", "vendor" },
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
    renderer = {
        indent_markers = {
            enable = true,
            icons = {
                corner = "│ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            webdev_colors = true,
        },
    },
    view = {
        width = 30,
        height = 30,
        hide_root_folder = true,
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
})
