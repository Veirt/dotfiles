local utils = require("utils")

local input_file = vim.fn.expand("%")
local run_cmd = vim.fn.expand("node ") .. input_file

utils.remap_run_on_tmux(run_cmd)
