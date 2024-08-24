local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local cmp_select = { behavior = cmp.SelectBehavior.Select }

local snippet = {
    expand = function(args)
        luasnip.lsp_expand(args.body)
    end,
}

local sources = {
    { name = "nvim_lsp" },
    { name = "luasnip", max_item_count = 30 },
    { name = "buffer", keyword_length = 3 },
    { name = "async_path" },
}

local mapping = cmp.mapping.preset.insert({
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
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
})

local formatting = {
    format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        show_labelDetails = true,
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
