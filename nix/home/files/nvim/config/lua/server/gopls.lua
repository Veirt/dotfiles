local M = {}

M.setup = function()
    vim.lsp.config("gopls", {
        settings = {
            gopls = {
                buildFlags = { "-tags=integration" },
            },
        },
    })
    vim.lsp.enable("gopls")
end

return M
