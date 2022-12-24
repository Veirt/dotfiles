return require("packer").startup({
    function()
        use("wbthomason/packer.nvim")

        use({
            "nvim-treesitter/nvim-treesitter",
            run = function()
                require("nvim-treesitter.install").update({ with_sync = true })
            end,
        })

        use({ "windwp/nvim-ts-autotag", opt = true })
        use({ "p00f/nvim-ts-rainbow", opt = true })
        use({ "JoosepAlviste/nvim-ts-context-commentstring", opt = true })
        use("numToStr/Comment.nvim")

        use({
            "VonHeikemen/lsp-zero.nvim",
            requires = {
                -- LSP Support
                { "neovim/nvim-lspconfig" },
                { "williamboman/mason.nvim" },
                { "williamboman/mason-lspconfig.nvim" },
                { "jose-elias-alvarez/nvim-lsp-ts-utils", requires = { "jose-elias-alvarez/null-ls.nvim" } },

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
        })

        use("Xevnar/filetype.nvim")
        -- use("mfussenegger/nvim-dap")
        use("ThePrimeagen/refactoring.nvim")

        use({ "posva/vim-vue", ft = "vue", opt = true }) -- Syntax with indent for Vue
        use({ "Vimjas/vim-python-pep8-indent", ft = "python", opt = true })
        use({ "MaxMEllon/vim-jsx-pretty", opt = true })
        use({ "pantharshit00/vim-prisma", ft = "prisma", opt = true })
        use({ "dag/vim-fish", ft = "fish", opt = true })
        use({ "nikvdp/ejs-syntax", opt = true })

        use("kyazdani42/nvim-tree.lua")
        use("numToStr/Navigator.nvim")

        use("windwp/nvim-autopairs")
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- Native fzf
            },
        })
        use({ "ThePrimeagen/harpoon", requires = { "nvim-lua/popup.nvim" } }) -- Get you where you want with the fewest keystrokes.
        use("lewis6991/gitsigns.nvim") -- Super fast git decorations
        use("glepnir/lspsaga.nvim") -- LSP plugin with highly performant UI
        use("ray-x/lsp_signature.nvim")
        use("ur4ltz/surround.nvim") -- Easily delete, change and add such surroundings in pairs.
        -- use("tpope/vim-sleuth") -- Automatically adjusts indent
        use("davidgranstrom/nvim-markdown-preview")
        use("gpanders/editorconfig.nvim")
        use("kdheepak/lazygit.nvim") -- Call lazygit within neovim

        use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in Neovim to improve startup time.
        use("tweekmonster/startuptime.vim")
        use("andweeb/presence.nvim")
        use("olimorris/persisted.nvim")
        use("frabjous/knap")

        -- Customization
        -- use("norcalli/nvim-colorizer.lua") -- A high-performance color highlighter for Neovim
        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
        })
        use("akinsho/bufferline.nvim") -- Tabline plugin
        use("goolord/alpha-nvim") -- Vim dashboard
        use("famiu/feline.nvim") -- A minimal, stylish and customizable statusline for Neovim written in Lua

        use({ "catppuccin/nvim", as = "catppuccin" })
        use("sainnhe/gruvbox-material")
        use("EdenEast/nightfox.nvim")
        use("RRethy/nvim-base16")
    end,
    config = {
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    },
})
