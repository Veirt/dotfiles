local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local utils = require("utils")

vim.diagnostic.config({
    virtual_text = false,
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup({ ensure_installed = {}, automatic_installation = true })
require("mason-nvim-lint").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
mason_lspconfig.setup_handlers({
    function(server_name) -- default handler
        lspconfig[server_name].setup({
            capabilities = capabilities,
        })
    end,
    ["vtsls"] = require("server.vtsls").setup(capabilities),
    ["clangd"] = require("server.clangd").setup,
    ["lua_ls"] = require("server.lua_ls").setup,
    ["texlab"] = require("server.texlab").setup,
    ["emmet_language_server"] = require("server.emmet_language_server").setup,
    ["intelephense"] = require("server.intelephense").setup,
})

autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
        local buf_set_keymap = utils.buf_map(args.buf)

        -- client.server_capabilities.semanticTokensProvider = nil

        buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
        buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
        buf_set_keymap("n", "<C-F>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
        buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_definitions<CR>")
        buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
        buf_set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
        buf_set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
        buf_set_keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>")
        buf_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
        buf_set_keymap("n", "<leader>er", "<cmd>Telescope diagnostics bufnr=0<CR>")
        buf_set_keymap("n", "<leader>eR", "<cmd>Telescope diagnostics<CR>")
        buf_set_keymap("n", "s", "<cmd>Telescope lsp_document_symbols<CR>")
        buf_set_keymap("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>")
        buf_set_keymap("n", "<leader>el", "<cmd>Lspsaga show_line_diagnostics<CR>")
        buf_set_keymap("n", "<leader>lo", "<cmd>Lspsaga outline<CR>")
        buf_set_keymap("n", "<leader>lr", "<cmd>LspRestart<CR>")

        -- Typescript
        buf_set_keymap("n", "<leader>tsi", ":VtsExec organize_imports<CR>")
        buf_set_keymap("n", "<leader>tsr", ":VtsExec rename_file<CR>")
        buf_set_keymap("n", "<leader>tsa", ":VtsExec add_missing_imports<CR>")
    end,
})

require("luasnip.loaders.from_vscode").lazy_load()

-- lsp loading status
require("fidget").setup({})
