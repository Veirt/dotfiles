local cmp = require("cmp")
local lsp = require("lsp-zero")

local M = {}

local cmp_select = { behavior = cmp.SelectBehavior.Select }

M.cmp_mappings = lsp.defaults.cmp_mappings({
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
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
    end, {
        "i",
        "s",
    }),
})
return M
