require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"python",
		"rust",
		"javascript",
		"typescript",
		"tsx",
		"lua",
		"fish",
		"bash",
		"latex",
		"dockerfile",
		"cpp",
		"java",
		"jsonc",
		"php",
		"toml",
		"vim",
		"vue",
		"yaml",
		"html",
		"css",
		"scss",
		"java",
		"c",
		"cpp",
		"cmake",
		"c_sharp",
	},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = false,
	},
	autotag = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	},
	textobjects = {
		enable = true,
	},
})
