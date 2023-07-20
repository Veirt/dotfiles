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
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            -- "windwp/nvim-ts-autotag",
            "HiPhish/nvim-ts-rainbow2",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "numToStr/Comment.nvim",
        },
    },

    -- lsp and debug stuffs
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- LSP Support
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "pmizio/typescript-tools.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Completions
            "hrsh7th/cmp-buffer",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            {
                "L3MON4D3/LuaSnip",
                version = "1.*",
                build = "make install_jsregexp",
                dependencies = "rafamadriz/friendly-snippets",
            },

            "onsails/lspkind-nvim", -- vscode-like pictograms
        },
    },
    { "ThePrimeagen/refactoring.nvim", lazy = true },
    { "j-hui/fidget.nvim", branch = "legacy" },
    {
        "linux-cultist/venv-selector.nvim",
        config = true,
        event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    },

    { "Vimjas/vim-python-pep8-indent", ft = "python", lazy = true },
    { "dag/vim-fish", ft = "fish", lazy = true },
    { "kyazdani42/nvim-tree.lua", dependencies = "kyazdani42/nvim-web-devicons", lazy = true },
    "numToStr/Navigator.nvim",
    "windwp/nvim-autopairs",
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
            }, -- Native fzf
        },
    },
    { "ThePrimeagen/harpoon", dependencies = "nvim-lua/popup.nvim", lazy = true }, -- Get you where you want with the fewest keystrokes.
    { "lewis6991/gitsigns.nvim", lazy = true }, -- Super fast git decorations
    { "nvimdev/lspsaga.nvim", event = "LspAttach" }, -- LSP plugin with highly performant UI
    { "ur4ltz/surround.nvim", lazy = true }, -- Easily delete, change and add such surroundings in pairs.
    { "NMAC427/guess-indent.nvim", lazy = true }, -- Automatically adjusts indent
    { "kdheepak/lazygit.nvim", cmd = "LazyGit" }, -- Call lazygit within neovim
    -- "olimorris/persisted.nvim", -- Session
    { dir = "~/dev/persisted.nvim" },
    { "zbirenbaum/copilot.lua", lazy = true },
    -- "akinsho/bufferline.nvim", -- Tabline plugin
    "sainnhe/gruvbox-material",
    "EdenEast/nightfox.nvim",
    "RRethy/nvim-base16",
    { "svrana/neosolarized.nvim", dependencies = "tjdevries/colorbuddy.nvim" },
}

require("lazy").setup(plugins)
