local cmp = require("cmp")

local cmp_select = { behavior = cmp.SelectBehavior.Select }

local snippet = {
    expand = function(args)
        require("luasnip").lsp_expand(args.body)
    end,
}

local sources = {
    { name = "nvim_lsp",  max_item_count = 30 },
    -- { name = "nvim_lsp_signature_help" },
    { name = "luasnip",   max_item_count = 30 },
    { name = "buffer",    keyword_length = 3 },
    { name = "async_path" },
    {
        name = "omni",
        option = {
            disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
        },
    },
}

local mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping(function(fallback)
        fallback()
    end), -- <CR> doesn't autocomplete
    ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.confirm({ select = true })
        else
            fallback() -- The fallback function sends an already mapped key. In this case, it's probably `<Tab>`.
        end
    end, {
        "i",
        "s",
    }),
})

local formatting = {
    format = require("lspkind").cmp_format({
        mode = "symbol_text",
        preset = "codicons",
        menu = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]",
        },
    }),
}

local completion = {
    completeopt = "menu,menuone,noinsert",
}

cmp.setup({
    snippet = snippet,
    mapping = mapping,
    completion = completion,
    sources = sources,
    formatting = formatting,
})
