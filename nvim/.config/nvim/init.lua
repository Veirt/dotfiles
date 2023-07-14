api = vim.api
opt = vim.opt
autocmd = api.nvim_create_autocmd

vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("plugins")

require("generals")
require("remaps")
require("themes")

-- absolutely disable continuous comment frfr no cap.
vim.cmd([[au! BufEnter * set fo-=c fo-=r fo-=o]])
