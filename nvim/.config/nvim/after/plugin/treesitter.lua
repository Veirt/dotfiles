require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "fish",
        "html",
        "javascript",
        "jsonc",
        "lua",
        "python",
        "rust",
        "typescript",
        "svelte",
        "vim",
        "yaml",
        "markdown",
        "markdown_inline",
        "vue",
        "vimdoc",
        "toml",
        "tsx",
        "sql",
        "scss",
        "scheme",
        "regex",
        "jsdoc",
        "go",
        "bibtex",
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        disable = { "yaml" },
    },
    autotag = {
        enable = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
    },
    context_commentstring = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<c-s>",
            node_decremental = "<M-space>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<A-l>"] = "@parameter.inner",
            },
            swap_previous = {
                ["<A-h>"] = "@parameter.inner",
            },
        },
    },
})
