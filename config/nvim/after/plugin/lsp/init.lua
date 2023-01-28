local null_ls = require("null-ls")
local lsp = require("lsp-zero")
local cmp_config = require("config.cmp")

local on_attach = require("config.on_attach")

null_ls.setup({
    on_attach = on_attach,
    sources = {
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.diagnostics.eslint,

        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.eslint_d,

        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "4", "-ci" },
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.hadolint, -- docker
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
    "intelephense",
})

lsp.nvim_workspace()

lsp.setup_nvim_cmp(cmp_config)

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