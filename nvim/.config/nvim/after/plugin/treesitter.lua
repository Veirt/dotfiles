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
    context_commentstring = {
        enable = false,
    },
    endwise = {
        enable = true,
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

require("nvim-treesitter.parsers").get_parser_configs().just = {
    install_info = {
        url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
        files = { "src/parser.c", "src/scanner.c" },
        branch = "main",
        -- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
    },
    maintainers = { "@IndianBoy42" },
}
