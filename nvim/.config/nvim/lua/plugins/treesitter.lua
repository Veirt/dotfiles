return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "RRethy/nvim-treesitter-endwise",
    },

    config = function()
        require("nvim-ts-autotag").setup({})

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
                "vim",
                "query",
                "vimdoc",
                "toml",
                "tsx",
                "sql",
                "typst",
                "scss",
                "scheme",
                "regex",
                "jsdoc",
                "go",
                "bibtex",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
                disable = { "yaml", "html" },
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
    end,
}
