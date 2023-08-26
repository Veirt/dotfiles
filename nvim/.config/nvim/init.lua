api = vim.api
opt = vim.opt
autocmd = api.nvim_create_autocmd

vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

api.nvim_create_user_command("W", "write", {})
api.nvim_create_user_command("Q", "quit", {})

autocmd("TextYankPost", {
    command = "lua vim.highlight.on_yank({timeout = 40})",
})
vim.cmd([[autocmd FileType help wincmd L]]) -- help vertical split

require("plugins")

require("generals")
require("remaps")
require("themes")

-- absolutely disable continuous comment frfr no cap.
vim.cmd([[au! FileType * setlocal  fo-=c fo-=r fo-=o]])
