local M = {}

local opts = { noremap = true, silent = true }

M.map = function(mode, bind, cmd)
    vim.api.nvim_set_keymap(mode, bind, cmd, opts)
end

M.buf_map = function(bufnr)
    local function map(mode, bind, cmd)
        vim.api.nvim_buf_set_keymap(bufnr, mode, bind, cmd, opts)
    end

    return map
end

return M
