local utils = require("utils")

utils.map("n", "<leader>vt", "<cmd>VimtexCompile<CR>")
utils.map("n", "<C-c>", "<cmd>update<CR><cmd>VimtexCompileSS<CR>")
