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
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    },
    { "windwp/nvim-ts-autotag" },
    { "mrjones2014/nvim-ts-rainbow" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    "numToStr/Comment.nvim",

    -- lsp
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "jose-elias-alvarez/typescript.nvim", dependencies = { "jose-elias-alvarez/null-ls.nvim" } },

            -- Completions
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },

            { "onsails/lspkind-nvim" }, -- vscode-like pictograms
        },
    },

    "mfussenegger/nvim-dap",
    "ThePrimeagen/refactoring.nvim",
    "j-hui/fidget.nvim",

    -- use({ "posva/vim-vue", ft = "vue", opt = true }) -- Syntax with indent for Vue
    { "Vimjas/vim-python-pep8-indent", ft = "python", lazy = true },
    { "MaxMEllon/vim-jsx-pretty",      lazy = true },
    { "pantharshit00/vim-prisma",      ft = "prisma", lazy = true },
    { "dag/vim-fish",                  ft = "fish",   lazy = true },
    { "nikvdp/ejs-syntax",             ft = "ejs",    lazy = true },

    "kyazdani42/nvim-tree.lua",
    "numToStr/Navigator.nvim",
    "windwp/nvim-autopairs",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Native fzf
        },
    },
    { "ThePrimeagen/harpoon",      dependencies = { "nvim-lua/popup.nvim" } }, -- Get you where you want with the fewest keystrokes.
    "lewis6991/gitsigns.nvim",                                            -- Super fast git decorations
    "glepnir/lspsaga.nvim",                                               -- LSP plugin with highly performant UI
    "ray-x/lsp_signature.nvim",
    "ur4ltz/surround.nvim",                                               -- Easily delete, change and add such surroundings in pairs.
    "tpope/vim-sleuth",                                                   -- Automatically adjusts indent
    "gpanders/editorconfig.nvim",
    "kdheepak/lazygit.nvim",                                              -- Call lazygit within neovim
    "gcmt/wildfire.vim",                                                  -- Quickly select the closest text object among a group of candidates
    "lewis6991/impatient.nvim",                                           -- Speed up loading Lua modules in Neovim to improve startup time.("tweekmonster/startuptime.vim")
    "andweeb/presence.nvim",                                              -- Discord Rich Presence
    -- "olimorris/persisted.nvim",                                           -- Session
    { dir = "~/dev/persisted.nvim" },
    "frabjous/knap", -- LaTeX preview
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
    },
    "akinsho/bufferline.nvim", -- Tabline plugin
    "goolord/alpha-nvim",      -- Vim dashboard
    "famiu/feline.nvim",       -- A minimal, stylish and customizable statusline for Neovim written in Lua

    -- Themes
    { "catppuccin/nvim", name = "catppuccin" },
    "sainnhe/gruvbox-material",
    "EdenEast/nightfox.nvim",
    "RRethy/nvim-base16",
}

require("lazy").setup(plugins)
