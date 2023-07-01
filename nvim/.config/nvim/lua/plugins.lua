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
    "windwp/nvim-ts-autotag",
    "HiPhish/nvim-ts-rainbow2",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "numToStr/Comment.nvim",

    {
        "vim-denops/denops.vim",
        dependencies = {
            "matsui54/denops-signature_help",
        },
    },

    -- lsp
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- LSP Support
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "lvimuser/lsp-inlayhints.nvim",
            { "jose-elias-alvarez/typescript.nvim", dependencies = { "jose-elias-alvarez/null-ls.nvim" } },
        },
    },

    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        dependencies = {
            -- Completions
            "hrsh7th/cmp-buffer",
            "FelipeLema/cmp-async-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-omni",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "lukas-reineke/cmp-rg",

            -- Snippets
            {
                "L3MON4D3/LuaSnip",
                version = "1.*",
                build = "make install_jsregexp",
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            { "onsails/lspkind-nvim" }, -- vscode-like pictograms
        },
    },

    "mfussenegger/nvim-dap",
    "ThePrimeagen/refactoring.nvim",
    { "j-hui/fidget.nvim",             branch = "legacy" },
    {
        "linux-cultist/venv-selector.nvim",
        config = true,
        event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    },

    -- use({ "posva/vim-vue", ft = "vue", opt = true }) -- Syntax with indent for Vue
    { "Vimjas/vim-python-pep8-indent", ft = "python",    lazy = true },
    { "MaxMEllon/vim-jsx-pretty",      lazy = true },
    { "dag/vim-fish",                  ft = "fish",      lazy = true },
    { "nikvdp/ejs-syntax",             ft = "ejs",       lazy = true },

    "kyazdani42/nvim-tree.lua",
    "numToStr/Navigator.nvim",
    "windwp/nvim-autopairs",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Native fzf
        },
    },
    { "ThePrimeagen/harpoon",    dependencies = { "nvim-lua/popup.nvim" }, lazy = true }, -- Get you where you want with the fewest keystrokes.
    { "lewis6991/gitsigns.nvim", lazy = true },                                        -- Super fast git decorations
    { "glepnir/lspsaga.nvim",    event = "LspAttach" },                                -- LSP plugin with highly performant UI
    "ur4ltz/surround.nvim",                                                            -- Easily delete, change and add such surroundings in pairs.
    "tpope/vim-sleuth",                                                                -- Automatically adjusts indent
    { "kdheepak/lazygit.nvim",     cmd = "LazyGit" },                                  -- Call lazygit within neovim
    "gcmt/wildfire.vim",                                                               -- Quickly select the closest text object among a group of candidates
    { "andweeb/presence.nvim",     lazy = true },                                      -- Discord Rich Presence
    -- "olimorris/persisted.nvim",                                           -- Session
    { dir = "~/dev/persisted.nvim" },
    -- "lervag/vimtex",
    -- "frabjous/knap", -- LaTeX preview
    { "zbirenbaum/copilot.lua",    lazy = true },
    "akinsho/bufferline.nvim",                                                  -- Tabline plugin
    "goolord/alpha-nvim",                                                       -- Vim dashboard
    { "famiu/feline.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } }, -- A minimal, stylish and customizable statusline for Neovim written in Lua
    { "catppuccin/nvim",   name = "catppuccin" },
    "sainnhe/gruvbox-material",
    "EdenEast/nightfox.nvim",
    "RRethy/nvim-base16",
    "FrenzyExists/aquarium-vim",
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    "shaunsingh/nord.nvim",
    "tjdevries/colorbuddy.nvim",
    "svrana/neosolarized.nvim",
    "Yazeed1s/oh-lucy.nvim",
}

require("lazy").setup(plugins)
