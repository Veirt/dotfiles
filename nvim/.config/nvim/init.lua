api = vim.api
cmd = vim.cmd
opt = vim.opt
command = api.nvim_create_user_command
autocmd = api.nvim_create_autocmd

vim.loader.enable()

require("plugins")

require("generals")
require("remaps")
require("themes")

-- absolutely disable continuous comment frfr no cap.
cmd([[au! BufEnter * set fo-=c fo-=r fo-=o]])
