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
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "yioneko/nvim-vtsls",
            "hrsh7th/nvim-cmp",
            "tamago324/nlsp-settings.nvim",
            -- "pmizio/typescript-tools.nvim",
            "nvimtools/none-ls.nvim",
            "nvimtools/none-ls-extras.nvim",
            "j-hui/fidget.nvim",
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

    { "Vimjas/vim-python-pep8-indent", ft = "python" },
    { "dag/vim-fish", ft = "fish" },
    { "iamcco/markdown-preview.nvim", ft = "markdown", build = "cd app && npm install" },
    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
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
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Completions
            "hrsh7th/cmp-buffer",
            "saadparwaiz1/cmp_luasnip",
            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
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

    { "ThePrimeagen/harpoon", dependencies = "nvim-lua/popup.nvim" }, -- Get you where you want with the fewest keystrokes.
    { "kdheepak/lazygit.nvim", cmd = "LazyGit" }, -- Call lazygit within neovim
    { "zbirenbaum/copilot.lua", lazy = true },
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
    { "svrana/neosolarized.nvim", dependencies = "tjdevries/colorbuddy.nvim" },
    "sainnhe/gruvbox-material",
    "EdenEast/nightfox.nvim",
    "RRethy/nvim-base16",
    "nvim-lualine/lualine.nvim",
}

require("lazy").setup(plugins)
