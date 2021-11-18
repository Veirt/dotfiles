vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("neovim/nvim-lspconfig")
	use("alexaandru/nvim-lspupdate")
	use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = { "jose-elias-alvarez/null-ls.nvim" } })

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-vsnip",
				"hrsh7th/vim-vsnip",
				"hrsh7th/vim-vsnip-integ",
				"rafamadriz/friendly-snippets",
			},
		},
	})

	use({ "jwalton512/vim-blade", ft = "blade" })
	use({ "lervag/vimtex", ft = "latex" }) -- Syntax plugin for LaTeX files.
	use({ "posva/vim-vue", ft = "vue" }) -- Syntax with indent for Vue
	use({ "othree/html5.vim", ft = "html" })
	use("MaxMEllon/vim-jsx-pretty")

	use("kyazdani42/nvim-tree.lua")
	use("christoomey/vim-tmux-navigator")

	use("terrortylor/nvim-comment")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("p00f/nvim-ts-rainbow")
	use("windwp/nvim-ts-autotag")
	use("jiangmiao/auto-pairs")
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- Native fzf
		},
	}) -- A highly extendable fuzzy finder over lists
	use({ "ThePrimeagen/harpoon", requires = { "nvim-lua/popup.nvim" } }) -- Get you where you want with the fewest keystrokes.
	use("lewis6991/gitsigns.nvim") -- Super fast git decorations
	use("sbdchd/neoformat") -- Format code/Prettier
	use({ "tami5/lspsaga.nvim", branch = "nvim51" }) -- LSP plugin with highly performant UI
	use("ray-x/lsp_signature.nvim")
	use("RishabhRD/popfix")
	use("RishabhRD/nvim-lsputils")
	use("blackCauldron7/surround.nvim") -- Easily delete, change and add such surroundings in pairs.
	use("tpope/vim-sleuth") -- Automatically adjusts indent
	use("davidgranstrom/nvim-markdown-preview")

	use("norcalli/nvim-colorizer.lua") -- A high-performance color highlighter for Neovim
	use("kdheepak/lazygit.nvim") -- Call lazygit within neovim
	use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in Neovim to improve startup time.
	use("tweekmonster/startuptime.vim")
	use("andweeb/presence.nvim")
	use("folke/persistence.nvim") -- Automated session management.

	-- Customization
	use("kyazdani42/nvim-web-devicons") -- A lua fork of vim-devicons
	use("onsails/lspkind-nvim") -- vscode-like pictograms
	use("akinsho/bufferline.nvim") -- Tabline plugin
	use("goolord/alpha-nvim") -- Vim dashboard
	use("folke/tokyonight.nvim")
	use("marko-cerovac/material.nvim")
	use("EdenEast/nightfox.nvim")
	use("famiu/feline.nvim") -- A minimal, stylish and customizable statusline for Neovim written in Lua
end)