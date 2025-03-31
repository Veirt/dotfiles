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
            -- "yioneko/nvim-vtsls",
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

    -- language supports
    { "folke/neodev.nvim", opts = {} },
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

    -- completion
    {
        "saghen/blink.cmp",
        version = "v1.*",
        dependencies = { "rafamadriz/friendly-snippets" },
    },

    -- improve experience
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
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

    { "kdheepak/lazygit.nvim", cmd = "LazyGit" }, -- Call lazygit within neovim
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

    -- themes
    "akinsho/bufferline.nvim",
    "kyazdani42/nvim-web-devicons",
    "craftzdog/solarized-osaka.nvim",
    -- "sainnhe/gruvbox-material",
    -- "EdenEast/nightfox.nvim",
    -- "RRethy/nvim-base16",
    "nvim-lualine/lualine.nvim",
    "folke/snacks.nvim",

    {
        dir = "~/dev/trun.nvim", --
        dependencies = { "ThePrimeagen/harpoon" },
        config = function()
            require("trun").setup()
        end,
    },
    {
        "vyfor/cord.nvim",
        build = ":Cord update",
        event = "VeryLazy",
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
    },
    "stefandtw/quickfix-reflector.vim",
    "dstein64/vim-startuptime",
}

require("lazy").setup(plugins)
