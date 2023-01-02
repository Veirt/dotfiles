local utils = require("utils")

local M = function(client, bufnr)
    require("lsp_signature").on_attach({
        floating_window = false,
    })

    local buf_set_keymap = utils.buf_map(bufnr)

    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    buf_set_keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>")

    buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_definitions<CR>")
    buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
    buf_set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    buf_set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    buf_set_keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>")
    buf_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
    buf_set_keymap("n", "<leader>er", "<cmd>Telescope diagnostics bufnr=0<CR>")
    buf_set_keymap("n", "<leader>eR", "<cmd>Telescope diagnostics<CR>")
    buf_set_keymap("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>")
    buf_set_keymap("n", "<leader>sd", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
    buf_set_keymap("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>")
    buf_set_keymap("n", "<leader>el", "<cmd>Lspsaga show_line_diagnostics<CR>")
    buf_set_keymap("n", "<leader>lr", "<cmd>LspRestart<CR>")

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

return M
