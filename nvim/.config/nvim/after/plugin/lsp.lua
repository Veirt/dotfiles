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
        "pyright",
        "tsserver",
        "rust_analyzer",
        "clangd",
        "texlab",
        "lua_ls",
    },
})

mason_nvim_dap.setup({ handlers = {} })

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
        null_ls.builtins.code_actions.refactoring,

        -- JS/TS
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.eslint_d,
        -- null_ls.builtins.diagnostics.eslint_d,

        -- LISP
        null_ls.builtins.formatting.emacs_scheme_mode,
        null_ls.builtins.formatting.raco_fmt,

        -- C/C++
        null_ls.builtins.formatting.clang_format,

        -- sh
        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "4", "-ci" },
        }),

        -- python
        null_ls.builtins.formatting.black,

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
        buf_set_keymap("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>")
        buf_set_keymap("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>")
        buf_set_keymap("n", "<leader>el", "<cmd>Lspsaga show_line_diagnostics<CR>")
        buf_set_keymap("n", "<leader>lo", "<cmd>Lspsaga outline<CR>")
        buf_set_keymap("n", "<leader>lr", "<cmd>LspRestart<CR>")
    end,
})

require("luasnip.loaders.from_vscode").lazy_load()

-- lsp loading status
require("fidget").setup({})

local format_is_enabled = true
vim.api.nvim_create_user_command("ToggleFormatting", function()
    format_is_enabled = not format_is_enabled
    print("Setting autoformatting to: " .. tostring(format_is_enabled))
end, {})

-- Create an augroup that is used for managing our formatting autocmds.
--      We need one augroup per client to make sure that multiple clients
--      can attach to the same buffer without interfering with each other.
local _augroups = {}
local get_augroup = function(client)
    if not _augroups[client.id] then
        local group_name = "kickstart-lsp-format-" .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
    end

    return _augroups[client.id]
end

autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach-format", { clear = true }),
    -- This is where we attach the autoformatting for reasonable clients
    callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
            return
        end

        -- Tsserver usually works poorly. Sorry you work with bad languages
        -- You can remove this line if you know what you're doing :)
        if client.name == "tsserver" or client.name == "typescript-tools" then
            return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
                if not format_is_enabled then
                    return
                end

                vim.lsp.buf.format({
                    async = false,
                    filter = function(c)
                        return c.id == client.id
                    end,
                })
            end,
        })
    end,
})
