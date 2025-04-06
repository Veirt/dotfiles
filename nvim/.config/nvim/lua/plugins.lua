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
            "pmizio/typescript-tools.nvim",
            "dmmulroy/ts-error-translator.nvim",
            "mfussenegger/nvim-lint",
            "j-hui/fidget.nvim",
            "stevearc/conform.nvim",
            "b0o/schemastore.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "rshkarin/mason-nvim-lint",
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
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "jay-babu/mason-nvim-dap.nvim",
        },
    },

    -- language supports
    { "Vimjas/vim-python-pep8-indent", ft = "python" },
    { "dag/vim-fish", ft = "fish" },
    {
        "HakonHarnes/img-clip.nvim",
        event = "BufEnter",
        keys = {
            { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
        },
    },
    { "kaarmu/typst.vim", ft = "typst" },
    { "NoahTheDuke/vim-just", ft = "just" },
    { "olexsmir/gopher.nvim", ft = "go" },

    -- completion
    {
        "saghen/blink.cmp",
        version = "v1.*",
        dependencies = { "rafamadriz/friendly-snippets" },
    },

    -- improve experience
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-frecency.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
    },
    "github/copilot.vim",
    {
        "jinzhongjia/LspUI.nvim",
        branch = "main",
    },
    "lewis6991/gitsigns.nvim", -- Super fast git decorations
    "kylechui/nvim-surround",
    "NMAC427/guess-indent.nvim", -- Automatically adjusts indent
    "kyazdani42/nvim-tree.lua",
    "numToStr/Navigator.nvim",
    "olimorris/persisted.nvim", -- Session
    "wakatime/vim-wakatime",
    "sustech-data/wildfire.nvim",
    "windwp/nvim-autopairs",
    {
        "veirt/trun.nvim",
        dependencies = { "ThePrimeagen/harpoon" },
    },
    {
        "vyfor/cord.nvim",
        build = ":Cord update",
        event = "VeryLazy",
    },
    {
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        event = { "VeryLazy" },
    },
    "stefandtw/quickfix-reflector.vim",
    -- "dstein64/vim-startuptime",

    -- themes
    "akinsho/bufferline.nvim",
    "kyazdani42/nvim-web-devicons",
    "craftzdog/solarized-osaka.nvim",
    -- "sainnhe/gruvbox-material",
    -- "EdenEast/nightfox.nvim",
    -- "RRethy/nvim-base16",
    "nvim-lualine/lualine.nvim",
    "folke/snacks.nvim",
}

require("lazy").setup(plugins)
