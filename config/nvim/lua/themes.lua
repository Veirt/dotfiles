local catppuccin = require("catppuccin")
-- local nightfox = require("nightfox")

vim.api.nvim_command([[augroup Color]])
vim.api.nvim_command([[autocmd!]])
vim.api.nvim_command([[au ColorScheme * hi LineNr guibg=NONE ctermbg=NONE guifg=#fff]])
vim.api.nvim_command([[au ColorScheme * hi CursorLineNr guifg=#fefefe]])
vim.api.nvim_command([[augroup END]])

vim.cmd([[sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=]])
vim.cmd([[sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=]])
vim.cmd([[sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=]])
vim.cmd([[sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=]])

-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_transparent_sidebar = true

-- nightfox.setup({
-- 	fox = "nordfox", -- change the colorscheme to use nordfox
-- 	transparent = true, -- Disable setting the background color
-- 	styles = {
-- 		comments = "italic", -- change style of comments to be italic
-- 		keywords = "bold", -- change style of keywords to be bold
-- 		functions = "italic,bold", -- styles can be a comma separated list
-- 	},
-- 	inverse = {
-- 		match_paren = true, -- inverse the highlighting of match_parens
-- 	},
-- })
-- nightfox.load()

catppuccin.setup({
	transparent_background = true,
	term_colors = true,
	styles = {
		comments = "italic",
		functions = "italic",
		keywords = "italic",
		strings = "NONE",
		variables = "NONE",
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = "italic",
				hints = "italic",
				warnings = "italic",
				information = "italic",
			},
			underlines = {
				errors = "underline",
				hints = "underline",
				warnings = "underline",
				information = "underline",
			},
		},
		lsp_trouble = false,
		lsp_saga = true,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = false,
		},
		which_key = false,
		indent_blankline = {
			enabled = false,
			colored_indent_levels = false,
		},
		dashboard = false,
		neogit = false,
		vim_sneak = false,
		fern = false,
		barbar = true,
		bufferline = false,
		markdown = false,
		lightspeed = false,
		ts_rainbow = false,
		hop = false,
	},
})

vim.cmd([[colorscheme catppuccin]])
