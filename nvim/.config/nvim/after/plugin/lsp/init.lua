local null_ls = require("null-ls")
local lsp = require("lsp-zero")
local cmp_config = require("config.cmp")

local on_attach = require("config.on_attach")

null_ls.setup({
    on_attach = on_attach,
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
    "lua_ls",
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

lsp.skip_server_setup({ "tsserver" })

lsp.setup()

require("luasnip.loaders.from_vscode").lazy_load()
