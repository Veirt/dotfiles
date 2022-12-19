local null_ls = require("null-ls")
local utils = require("utils")

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
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

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

local lsp = require("lsp-zero")
local luasnip = require("luasnip")

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

-- CMP
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.confirm({ select = true })
            -- elseif luasnip and luasnip.expand_or_jumpable() then
            --     return t("<Plug>luasnip-expand-or-jump")
        else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
    end, {
        "i",
        "s",
    }),
})

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
    mapping = cmp_mappings,
})

lsp.on_attach = on_attach

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
    float = true,
})

lsp.setup()
