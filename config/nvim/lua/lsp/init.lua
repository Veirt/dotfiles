local nvim_lsp = require("lspconfig")
local null_ls = require("null-ls")
local configs = require("lspconfig.configs")
local utils = require("utils")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
})

local function lspSymbol(name, icon)
    vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, numhl = "DiagnosticDefault" .. name })
end

lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Info", "")
lspSymbol("Warning", "")

local on_attach = function(client, bufnr)
    require("lsp_signature").on_attach({
        floating_window = false,
    })

    local buf_set_keymap = utils.buf_map(bufnr)

    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    buf_set_keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>")

    buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_definitions<CR>")
    buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
    buf_set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    buf_set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    buf_set_keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>")
    buf_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
    buf_set_keymap("n", "<leader>er", "<cmd>Telescope diagnostics bufnr=0<CR>")
    buf_set_keymap("n", "<leader>eR", "<cmd>Telescope diagnostics<CR>")
    buf_set_keymap("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>")
    buf_set_keymap("n", "<leader>sd", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
    buf_set_keymap("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>")
    buf_set_keymap("n", "<leader>el", "<cmd>Lspsaga show_line_diagnostics<CR>")
    buf_set_keymap("n", "<leader>lr", "<cmd>LspRestart<CR>")

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                vim.lsp.buf.formatting_seq_sync()
            end,
        })
    end
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
    "pyright",
    "bashls",
    "vimls",
    "yamlls",
    "dockerls",
    "sqls",
    "html",
    "cssls",
    "jsonls",
    "intelephense",
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

nvim_lsp.rust_analyzer.setup({

    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
        },
    },
})

-- vue
nvim_lsp.volar.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    documentFeatures = {
        foldingRange = false,
    },
    languageFeatures = {
        codeAction = false,
        codeLens = false,
    },
})

null_ls.setup({
    on_attach = on_attach,
    sources = {
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "4", "-ci" },
        }),
        null_ls.builtins.formatting.nginx_beautifier,
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.hadolint, -- docker
        -- null_ls.builtins.code_actions.eslint_d,
        -- null_ls.builtins.code_actions.refactoring,
    },
})

nvim_lsp.emmet_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "css", "ejs", "typescriptreact", "javascriptreact" },
})
