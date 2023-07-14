local M = {}

M.setup = function()
    require("lspconfig")["lua_ls"].setup({
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    })
end

return M
