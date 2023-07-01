local null_ls = require("null-ls")
local lspconfig = require("lspconfig")
local get_servers = require("mason-lspconfig").get_installed_servers

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "clangd",
        "tsserver",
        "bashls",
        "svelte",
        "volar",
        "jsonls",
    },
})

vim.diagnostic.config({
    virtual_text = false,
})

null_ls.setup({
    sources = {
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.diagnostics.eslint,

        null_ls.builtins.formatting.prettierd.with({
            filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
                "css",
                "scss",
                "less",
                "html",
                "json",
                "jsonc",
                "yaml",
                "markdown.mdx",
                "graphql",
                "handlebars",
            },
        }),
        -- null_ls.builtins.formatting.eslint_d,

        null_ls.builtins.formatting.emacs_scheme_mode,
        null_ls.builtins.formatting.raco_fmt,
        null_ls.builtins.formatting.clang_format,

        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "4", "-ci" },
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.hadolint, -- docker
        -- null_ls.builtins.diagnostics.cpplint,
    },
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, server_name in ipairs(get_servers()) do
    lspconfig[server_name].setup({
        capabilities = lsp_capabilities,
    })
end

local utils = require("utils")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local toggleFormattingStatus = true

local function formatOnSave(bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    if toggleFormattingStatus == true then
        autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = false })
            end,
        })
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local buf_set_keymap = utils.buf_map(ev.buf)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        -- client.server_capabilities.semanticTokensProvider = nil

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

        formatOnSave(ev.buf)
    end,
})

function ToggleFormatting()
    local bufnr = vim.api.nvim_get_current_buf()

    if toggleFormattingStatus == false then
        toggleFormattingStatus = true
        formatOnSave()
        print("Formatting enabled")
    else
        toggleFormattingStatus = false
        vim.api.nvim_clear_autocmds({ group = augroup })
        print("Formatting disabled")
    end
end

require("luasnip.loaders.from_vscode").lazy_load()
