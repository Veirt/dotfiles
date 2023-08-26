local M = {}

local opts = { noremap = true, silent = true }

M.map = function(mode, bind, cmd)
    api.nvim_set_keymap(mode, bind, cmd, opts)
end

M.buf_map = function(bufnr)
    local function map(mode, bind, cmd)
        api.nvim_buf_set_keymap(bufnr, mode, bind, cmd, opts)
    end

    return map
end

M.remap_run_on_tmux = function(cmd_to_send)
    local bufnr = api.nvim_get_current_buf()
    local buf_set_keymap = M.buf_map(bufnr)

    local cmd = string.format(":lua require('harpoon.tmux').sendCommand('2', '%s')", cmd_to_send)

    buf_set_keymap("n", "<C-c>", string.format("<cmd>%s<CR>", cmd))
end

return M
