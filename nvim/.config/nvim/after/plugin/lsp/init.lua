local null_ls = require("null-ls")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local utils = require("utils")

vim.diagnostic.config({
    virtual_text = false,
})

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "pyright",
        "tsserver",
        "rust_analyzer",
        "clangd",
        "bashls",
        "lua_ls",
        "jsonls",
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

mason_lspconfig.setup_handlers({
    function(server_name) -- default handler
        lspconfig[server_name].setup({
            capabilities = capabilities,
        })
    end,
    ["tsserver"] = require("server.tsserver").setup,
    ["clangd"] = require("server.clangd").setup,
    ["lua_ls"] = require("server.lua_ls").setup,
    ["texlab"] = require("server.texlab").setup,
})

null_ls.setup({
    sources = {
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
    },
})

local toggleFormattingStatus = true
local function formatOnSave(bufnr)
    autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            if not toggleFormattingStatus then
                return
            end

            vim.lsp.buf.format({ bufnr = bufnr, async = false })
        end,
    })
end

function ToggleFormatting()
    local bufnr = vim.api.nvim_get_current_buf()
    toggleFormattingStatus = not toggleFormattingStatus
    print("Format on save: " .. tostring(toggleFormattingStatus))
end

autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local buf_set_keymap = utils.buf_map(ev.buf)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
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
        buf_set_keymap("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>")
        buf_set_keymap("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>")
        buf_set_keymap("n", "<leader>el", "<cmd>Lspsaga show_line_diagnostics<CR>")
        buf_set_keymap("n", "<leader>lo", "<cmd>Lspsaga outline<CR>")
        buf_set_keymap("n", "<leader>lr", "<cmd>LspRestart<CR>")

        if client.server_capabilities.documentFormattingProvider then
            formatOnSave(ev.buf)
        end
    end,
})

require("luasnip.loaders.from_vscode").lazy_load()

-- lsp loading status
require("fidget").setup({})
