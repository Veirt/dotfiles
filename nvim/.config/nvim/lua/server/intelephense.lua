local M = {}

M.setup = function()
    require("lspconfig").intelephense.setup({
        init_options = {
            globalStoragePath = os.getenv("HOME") .. "/.local/share/intelephense",
        },
    })
end

return M
