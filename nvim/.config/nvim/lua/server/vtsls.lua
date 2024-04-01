local M = {}

M.setup = function(capabilities)
    return function()
        require("lspconfig.configs").vtsls = require("vtsls").lspconfig -- set default server config, optional but recommended
        require("lspconfig").vtsls.setup({ capabilities = capabilities })
        require("vtsls").config({})
    end
end

return M
