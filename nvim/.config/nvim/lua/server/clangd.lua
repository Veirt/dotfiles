local M = {}

M.setup = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.offsetEncoding = { "utf-16" }

    require("lspconfig").clangd.setup({ capabilities = capabilities })
end

return M
