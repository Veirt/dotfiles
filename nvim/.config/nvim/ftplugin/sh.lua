local utils = require("utils")

local input_file = vim.fn.expand("%")
local run_cmd = input_file

utils.remap_run_on_tmux(run_cmd)
