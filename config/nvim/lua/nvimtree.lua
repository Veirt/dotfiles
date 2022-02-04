-- <CR> or o on .. will cd in the above directory
-- <C-]> will cd in the directory under the cursor
-- <BS> will close current opened directory or parent
-- type a to add a file. Adding a directory requires leaving a leading / at the end of the path.
-- type r to rename a file
-- type <C-r> to rename a file and omit the filename on input
-- type x to add/remove file/directory to cut clipboard
-- type c to add/remove file/directory to copy clipboard type y will copy name to system clipboard
-- type Y will copy relative path to system clipboard
-- type gy will copy absolute path to system clipboard
-- type p to paste from clipboard. Cut clipboard has precedence over copy (will prompt for confirmation)
-- type d to delete a file (will prompt for confirmation)
-- type ]c to go to next git item
-- type [c to go to prev git item
-- type - to navigate up to the parent directory of the current file/directory
-- type s to open a file with default system application or a folder with default file manager (if you want to change the command used to do it see :h g:nvim_tree_system_open_command and :h g:nvim_tree_system_open_command_args)
-- if the file is a directory, <CR> will open the directory otherwise it will open the file in the buffer near the tree
-- if the file is a symlink, <CR> will follow the symlink (if the target is a file)
-- <C-v> will open the file in a vertical split
-- <C-x> will open the file in a horizontal split
-- <C-t> will open the file in a new tab
-- <Tab> will open the file as a preview (keeps the cursor in the tree)
-- I will toggle visibility of folders hidden via |g:nvim_tree_ignore|
-- H will toggle visibility of dotfiles (files/folders starting with a .)
-- R will refresh the tree
-- Double left click acts like <CR>
-- Double right click acts like <C-]>

local g = vim.g

vim.api.nvim_set_keymap("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

g.nvim_tree_indent_markers = 1
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
