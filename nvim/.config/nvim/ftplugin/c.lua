if vim.bo.filetype ~= "c" then
    return
end

local utils = require("utils")

local exist = vim.fn.findfile("Makefile")
if exist ~= "" then
    utils.remap_run_on_tmux(string.format("%s; %s", "make", "make run"))
else
    local input_file = vim.fn.expand("%")
    local output_file = vim.fn.expand("%:p:r") .. ".out"
    local build_cmd = string.format("gcc -o %s %s", output_file, input_file)
    local run_cmd = vim.fn.expand("%:p:r") .. ".out"
    utils.remap_run_on_tmux(string.format("%s; %s", build_cmd, run_cmd))
end
