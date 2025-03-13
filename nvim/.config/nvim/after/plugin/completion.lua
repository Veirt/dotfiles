require("blink.cmp").setup({
    keymap = {
        preset = "super-tab",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
    },
    snippets = {
        preset = "luasnip",
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
    },
    signature = { enabled = true },
    completion = {
        menu = {
            draw = {
                columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            },
        },
        documentation = {
            auto_show = true,
        },
    },
})
