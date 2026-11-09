local utils = require("utils")

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- LSP Support
        { "nvim-flutter/flutter-tools.nvim", ft = "dart" },
        "dmmulroy/ts-error-translator.nvim",
        "j-hui/fidget.nvim",
        "b0o/schemastore.nvim",
        "williamboman/mason.nvim",
    },

    config = function()
        vim.diagnostic.config({
            virtual_text = false,
        })
        vim.lsp.inlay_hint.enable(false)

        require("fidget").setup({})
        -- LSP executables are pinned and exposed by mise; keep Mason's PATH
        -- untouched so stale Mason installs cannot shadow them.
        require("mason").setup({ PATH = "skip" })

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

        local function typst_project_root(bufname)
            return vim.fs.root(bufname, { "main.typ", ".git" }) or vim.fn.getcwd()
        end

        vim.lsp.config("tinymist", {
            root_dir = function(bufnr, on_dir)
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                on_dir(typst_project_root(bufname))
            end,
            settings = {
                tinymist = {
                    projectResolution = "lockDatabase",
                },
            },
        })

        vim.lsp.enable("rust_analyzer")
        vim.lsp.enable("pyrefly")
        vim.lsp.enable("tinymist")

        local vtsls_server = require("server.vtsls")
        local tsc_server = require("server.tsc")
        local jsonls_server = require("server.jsonls")
        local gopls_server = require("server.gopls")

        -- tsc provides normal language features; vtsls only provides import actions.
        -- vtsls_server.setup(capabilities)
        tsc_server.setup(capabilities)
        jsonls_server.setup()
        gopls_server.setup()

        autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                local buf_set_keymap = utils.buf_map(args.buf)
                local bufname = vim.api.nvim_buf_get_name(args.buf)

                if client and client.name == "tinymist" then
                    local root = typst_project_root(bufname)
                    local main = vim.fs.joinpath(root, "main.typ")
                    if vim.uv.fs_stat(main) then
                        client:exec_cmd({
                            command = "tinymist.pinMain",
                            arguments = { main },
                        }, { bufnr = args.buf })
                    end
                end

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
                buf_set_keymap("n", "<leader>tsi", "<cmd>lua vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } } })<CR>")
                buf_set_keymap("n", "<leader>tsa", "<cmd>lua vim.lsp.buf.code_action({ context = { diagnostics = vim.diagnostic.get(0) } })<CR>")
            end,
        })
    end,
}
