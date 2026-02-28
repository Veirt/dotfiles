local M = {}

M.setup = function()
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })
    vim.lsp.enable("lua_ls")
end

return M
