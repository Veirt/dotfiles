local utils = require("utils")

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- LSP Support
        "yioneko/nvim-vtsls",
        { "nvim-flutter/flutter-tools.nvim", ft = "dart" },
        "dmmulroy/ts-error-translator.nvim",
        "j-hui/fidget.nvim",
        "b0o/schemastore.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "rshkarin/mason-nvim-lint",
    },

    config = function()
        vim.diagnostic.config({
            virtual_text = false,
        })
        vim.lsp.inlay_hint.enable(false)

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_enable = {
                exclude = {
                    "ts_ls",
                    "clangd",
                    "vtsls",
                    "denols",
                    "jsonls",
                },
            },
        })

        local capabilities = {
            workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = true,
                },
            },
            textDocument = {
                formatting = { dynamicRegistration = false },
            },
        }
        capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

        local vtsls_server = require("server.vtsls")
        local jsonls_server = require("server.jsonls")
        local gopls_server = require("server.gopls")

        vtsls_server.setup(capabilities)
        jsonls_server.setup()
        gopls_server.setup()

        autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(args)
                local buf_set_keymap = utils.buf_map(args.buf)

                -- client.server_capabilities.semanticTokensProvider = nil

                buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
                buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
                buf_set_keymap("n", "gr", "<cmd>LspUI reference<CR>")
                buf_set_keymap("n", "<C-F>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
                buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
                buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
                buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
                buf_set_keymap("n", "<F2>", "<cmd>LspUI rename<CR>")
                buf_set_keymap("n", "<leader>ca", "<cmd>LspUI code_action<CR>")
                buf_set_keymap("n", "<leader>er", "<cmd>Telescope diagnostics bufnr=0<CR>")
                buf_set_keymap("n", "<leader>eR", "<cmd>Telescope diagnostics<CR>")
                buf_set_keymap("n", "s", "<cmd>Telescope lsp_document_symbols<CR>")
                buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>")
                buf_set_keymap("n", "<leader>el", "<cmd>lua vim.diagnostic.open_float()<CR>")
                buf_set_keymap("n", "<leader>lr", "<cmd>LspRestart<CR>")

                -- Typescript
                buf_set_keymap("n", "<leader>tsi", ":VtsExec organize_imports<CR>")
                buf_set_keymap("n", "<leader>tsr", ":VtsExec rename_file<CR>")
                buf_set_keymap("n", "<leader>tsa", ":VtsExec add_missing_imports<CR>")
            end,
        })
    end,
}
