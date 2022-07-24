api = vim.api
cmd = vim.cmd
opt = vim.opt

command = api.nvim_create_user_command
autocmd = api.nvim_create_autocmd

require("impatient")
require("packer_compiled")
require("plugins")

require("generals")
require("remaps")
require("session")
require("filetype-nvim")
require("nvimtree")
require("dashboard")
require("statusline")
require("themes")
require("treesitter")
require("refactoring-nvim")
require("lsp")
require("lsp.tsutils")
require("lsp.lspsaga")
require("telescope.custom")
require("nvim-comment")
require("nvim-cmp")
-- lua require('nvim-dap')
require("others")

-- absolutely disable continuous comment frfr no cap.
cmd([[au! BufEnter * set fo-=c fo-=r fo-=o]])
