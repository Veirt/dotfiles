return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "RRethy/nvim-treesitter-endwise",
    },

    config = function()
        require("nvim-ts-autotag").setup({})

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "bash",
                "c",
                "cpp",
                "css",
                "dockerfile",
                "fish",
                "html",
                "javascript",
                "json",
                "json5",
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
            callback = function()
                vim.treesitter.start()
                -- folds, provided by Neovim
                -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                -- vim.wo.foldmethod = "expr"
                -- indentation, provided by nvim-treesitter
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        -- configuration
        require("nvim-treesitter-textobjects").setup({
            select = {
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V", -- linewise
                    -- ['@class.outer'] = '<c-v>', -- blockwise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true of false
                include_surrounding_whitespace = false,
            },
        })

        -- keymaps
        -- You can use the capture groups defined in `textobjects.scm`
        vim.keymap.set({ "x", "o" }, "am", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "im", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "ac", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "ic", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
        end)
        -- You can also use captures from other query groups like `locals.scm`
        vim.keymap.set({ "x", "o" }, "as", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
        end)

        vim.keymap.set("n", "<A-l>", function()
            require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
        end)

        vim.keymap.set("n", "<A-L>", function()
            require("nvim-treesitter-textobjects.swap").swap_next("@parameter.outer")
        end)

        vim.keymap.set("n", "<A-h>", function()
            require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
        end)

        vim.keymap.set("n", "<A-H>", function()
            require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
        end)
    end,
}
