local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
opt.rtp:prepend(lazypath)

local plugins = {
    -- lsp and debug stuffs
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- LSP Support
            "yioneko/nvim-vtsls",
            "hrsh7th/nvim-cmp",
            "mfussenegger/nvim-lint",
            "j-hui/fidget.nvim",
            "stevearc/conform.nvim",

            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "rshkarin/mason-nvim-lint",
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "jay-babu/mason-nvim-dap.nvim",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "windwp/nvim-ts-autotag",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "numToStr/Comment.nvim",
            "RRethy/nvim-treesitter-endwise",
        },
    },

    { "folke/neodev.nvim", opts = {} },
    -- { "jlcrochet/vim-razor", ft = "razor" },
    { "Vimjas/vim-python-pep8-indent", ft = "python" },
    { "dag/vim-fish", ft = "fish" },
    {
        "HakonHarnes/img-clip.nvim",
        event = "BufEnter",
        opts = {},
        keys = {
            { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
        },
    },
    { "kaarmu/typst.vim", ft = "typst" },
    { "NoahTheDuke/vim-just", ft = "just" },
    { "olexsmir/gopher.nvim", ft = "go" },

    -- {
    --     "iguanacucumber/magazine.nvim",
    --     name = "nvim-cmp",
    --     dependencies = {
    --         -- Completions
    --         { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
    --         { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
    --         { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
    --         "https://codeberg.org/FelipeLema/cmp-async-path",
    --         {
    --             "L3MON4D3/LuaSnip",
    --             version = "1.*",
    --             build = "make install_jsregexp",
    --             dependencies = "rafamadriz/friendly-snippets",
    --         },
    --
    --         "onsails/lspkind-nvim", -- vscode-like pictograms
    --     },
    -- },
    {
        "saghen/blink.cmp",
        version = "v0.*",
        -- !Important! Make sure you're using the latest release of LuaSnip
        -- `main` does not work at the moment
        dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
        opts = {
            keymap = {
                preset = "super-tab",
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
            },
            snippets = {
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },
            sources = {
                default = { "lsp", "path", "luasnip", "buffer" },
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
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
    },

    { "kdheepak/lazygit.nvim", cmd = "LazyGit" }, -- Call lazygit within neovim
    { "github/copilot.vim" },
    -- "ThePrimeagen/refactoring.nvim",
    "nvimdev/lspsaga.nvim", -- LSP plugin with highly performant UI
    "lewis6991/gitsigns.nvim", -- Super fast git decorations
    "ur4ltz/surround.nvim", -- Easily delete, change and add such surroundings in pairs.
    "NMAC427/guess-indent.nvim", -- Automatically adjusts indent
    "kyazdani42/nvim-tree.lua",
    "numToStr/Navigator.nvim",
    "olimorris/persisted.nvim", -- Session
    "wakatime/vim-wakatime",
    "sustech-data/wildfire.nvim",
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
    },

    "akinsho/bufferline.nvim",
    "kyazdani42/nvim-web-devicons",
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
    },
    -- "sainnhe/gruvbox-material",
    -- "EdenEast/nightfox.nvim",
    -- "RRethy/nvim-base16",
    "nvim-lualine/lualine.nvim",
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },

    {
        dir = "~/dev/trun.nvim", --
        dependencies = { "ThePrimeagen/harpoon" },
        config = function()
            require("trun").setup()
        end,
    },
    {
        "vyfor/cord.nvim",
        build = "./build",
        event = "VeryLazy",
        opts = {
            editor = {
                tooltip = "Neovim",
            },
        },
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
}

require("lazy").setup(plugins)
