local M = {}

M.setup = function()
    require("lspconfig").jsonls.setup({
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    })
end

return M
