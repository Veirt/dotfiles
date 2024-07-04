local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_nvim_dap = require("mason-nvim-dap")
local utils = require("utils")

vim.diagnostic.config({
    virtual_text = false,
})

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "basedpyright",
        "vtsls",
        "rust_analyzer",
        "clangd",
        "texlab",
        "lua_ls",
    },
})

mason_nvim_dap.setup({ handlers = {} })

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

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.refactoring,

        -- JS/TS
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.rustywind,
        -- null_ls.builtins.formatting.eslint_d,
        -- null_ls.builtins.diagnostics.eslint_d,

        -- LISP
        null_ls.builtins.formatting.emacs_scheme_mode,
        null_ls.builtins.formatting.raco_fmt,

        -- Python
        null_ls.builtins.formatting.black,

        -- -- C/C++
        -- null_ls.builtins.formatting.clang_format,

        -- sh
        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "4", "-ci" },
        }),

        -- typst
        null_ls.builtins.formatting.typstfmt,

        -- lua
        null_ls.builtins.formatting.stylua,

        -- docker
        null_ls.builtins.diagnostics.hadolint,
    },
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
