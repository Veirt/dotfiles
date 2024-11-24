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

    {
        "iguanacucumber/magazine.nvim",
        name = "nvim-cmp",
        dependencies = {
            -- Completions
            { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
            { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
            { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
            {
                "L3MON4D3/LuaSnip",
                version = "1.*",
                build = "make install_jsregexp",
                dependencies = "rafamadriz/friendly-snippets",
            },

            "onsails/lspkind-nvim", -- vscode-like pictograms
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
}

require("lazy").setup(plugins)
