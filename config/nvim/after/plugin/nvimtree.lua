local present, nvim_tree = pcall(require, "nvim-tree")

if not present then
    return
end

nvim_tree.setup({
    disable_netrw = true,
    hijack_netrw = true,
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
        custom = { "^.git$", ".cache", "__pycache__", "vendor" },
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
    renderer = {
        icons = {
            webdev_colors = true,
            glyphs = {
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
            },
        },
        root_folder_label = true,
    },
    view = {
        width = 30,
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
})
