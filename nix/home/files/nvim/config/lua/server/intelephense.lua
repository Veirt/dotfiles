local M = {}

M.setup = function()
    vim.lsp.config("intelephense", {
        settings = {
            intelephense = {
                files = {
                    maxSize = 5000000, -- 5 MB
                },
                environment = {
                    includePaths = { "/usr/local/lib/php" },
                },
            },
        },
    })
    vim.lsp.enable("intelephense")
end

return M
