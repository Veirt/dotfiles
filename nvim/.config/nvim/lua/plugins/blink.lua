return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "super-tab",
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
        },

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

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        signature = { enabled = true },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
