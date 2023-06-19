local utils = require("utils")

require("typescript").setup({
    disable_commands = false,
    debug = false,
    go_to_source_definition = {
        fallback = true,
    },
    server = { -- pass options to lspconfig's setup method
        on_attach = function(client, bufnr)
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false

            local buf_set_keymap = utils.buf_map(bufnr)

            buf_set_keymap("n", "<leader>tsi", ":TypescriptOrganizeImports<CR>")
            buf_set_keymap("n", "<leader>tsr", ":TypescriptRenameFile<CR>")
            buf_set_keymap("n", "<leader>tsa", ":TypescriptAddMissingImports<CR>")
        end,
    },
})
