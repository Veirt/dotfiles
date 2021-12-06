local nvim_lsp = require("lspconfig")
local null_ls = require("null-ls")
local configs = require("lspconfig/configs")

-- Disable annoying error messages
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
})

local on_attach = function(client, bufnr)
    require("lsp_signature").on_attach({
        floating_window = false,
    })

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }

    -- buf_set_keymap('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
        })
        ts_utils.setup_client(client)

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tsi", ":TSLspOrganize<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tsr", ":TSLspRenameFile<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tsa", ":TSLspImportAll<CR>", opts)
    end

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command([[augroup Format]])
        vim.api.nvim_command([[autocmd! * <buffer>]])
        vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
        vim.api.nvim_command([[augroup END]])
    end
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
    "pylsp",
    "bashls",
    "vimls",
    "yamlls",
    "dockerls",
    "rust_analyzer",
    "texlab",
    "sqls",
    "html",
    "cssls",
    "emmet_ls",
    "jsonls",
    "prismals",
    "intelephense",
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

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

-- typescript
nvim_lsp.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

null_ls.config({
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.shfmt, -- shell
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.black, -- python
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.diagnostics.hadolint, -- docker
        null_ls.builtins.formatting.trim_whitespace,
    },
})

nvim_lsp["null-ls"].setup({
    on_attach = on_attach,
})