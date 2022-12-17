opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.relativenumber = true
opt.nu = true
opt.termguicolors = true
opt.errorbells = false
opt.wrap = false
opt.scrolloff = 8
opt.incsearch = true
opt.signcolumn = "yes"
opt.shell = "/bin/bash"

opt.tabstop = 4 -- number of columns occupied by a tab
opt.softtabstop = 4 -- see multiple spaces as tabstops so <BS> does the right thing
opt.expandtab = true -- convert tabs to whitespaces
opt.shiftwidth = 4 -- width for autoindent
opt.smartindent = true
opt.autoindent = true

opt.showmode = false -- hide built-in vim mode
opt.mouse = "a" -- enable mouse click
opt.ttyfast = true -- speed up scrolling
opt.hidden = true -- change buffer without save
opt.cursorline = true -- highlight currrent line
opt.foldenable = false

opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undodir = os.getenv("HOME") .. "/.local/share/vim/undodir"
opt.undofile = true
opt.updatetime = 50
opt.shortmess:append("c")

command("W", "write", {})
command("Q", "quit", {})

api.nvim_set_keymap("n", "<Space>", "<Leader>", {})

autocmd("TextYankPost", {
    pattern = "*",
    command = "lua vim.highlight.on_yank({timeout = 40})",
})
