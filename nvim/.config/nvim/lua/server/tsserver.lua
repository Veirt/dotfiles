local utils = require("utils")

local M = {}
M.setup = function()
    require("typescript-tools").setup({
        on_attach = function(client, bufnr)
            local buf_set_keymap = utils.buf_map(bufnr)

            buf_set_keymap("n", "<leader>tsi", ":TSToolsOrganizeImports<CR>")
            buf_set_keymap("n", "<leader>tsr", ":TypescriptRenameFile<CR>")
            buf_set_keymap("n", "<leader>tsa", ":TSToolsAddMissingImports<CR>")
        end,
        settings = {
            -- spawn additional tsserver instance to calculate diagnostics on it
            separate_diagnostic_server = true,
            -- "change"|"insert_leave" determine when the client asks the server about diagnostic
            publish_diagnostic_on = "insert_leave",
            -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
            -- (see 💅 `styled-components` support section)
            tsserver_plugins = {},
            tsserver_max_memory = 20000,
            -- described below
            tsserver_format_options = {},
            tsserver_file_preferences = {},
            complete_function_calls = true,
        },
    })
end

return M
