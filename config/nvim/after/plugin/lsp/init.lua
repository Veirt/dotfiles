local null_ls = require("null-ls")
local lsp = require("lsp-zero")
local cmp_config = require("config.cmp")

local on_attach = require("config.on_attach")

null_ls.setup({
    on_attach = on_attach,
    sources = {
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "4", "-ci" },
        }),
        null_ls.builtins.formatting.nginx_beautifier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.hadolint, -- docker
        null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.code_actions.eslint_d,
        -- null_ls.builtins.code_actions.refactoring,
    },
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = true,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    call_servers = "local",
    sign_icons = {
        error = "",
        warn = "",
        hint = "",
        info = "",
    },
})

lsp.ensure_installed({
    "pyright",
    "rust_analyzer",
    "tsserver",
    "clangd",
    "html",
    "cssls",
    "jsonls",
    "emmet_ls",
    "bashls",
    "vimls",
    "yamlls",
    "dockerls",
    "sqls",
    "intelephense",
})

lsp.nvim_workspace()

lsp.setup_nvim_cmp({
    sources = {
        { name = "nvim_lsp", keyword_length = 3 },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
    },
    formatting = {
        format = require("lspkind").cmp_format({ maxwidth = 50 }),
    },
    mapping = cmp_config.cmp_mappings,
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
})

lsp.on_attach(on_attach)

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
    float = true,
})

lsp.setup()
