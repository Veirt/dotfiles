-- require("catppuccino").setup({
-- 	colorscheme = "soft_manilo",
-- 	transparency = true,
-- 	term_colors = true,
-- 	integrations = {
-- 		treesitter = true,
-- 		native_lsp = {
-- 			enabled = true,
-- 			virtual_text = {
-- 				errors = "italic",
-- 				hints = "italic",
-- 				warnings = "italic",
-- 				information = "italic",
-- 			},
-- 			underlines = {
-- 				errors = "underline",
-- 				hints = "underline",
-- 				warnings = "underline",
-- 				information = "underline",
-- 			},
-- 		},
-- 		lsp_trouble = true,
-- 		lsp_saga = true,
-- 		gitsigns = true,
-- 		telescope = true,
-- 		nvimtree = {
-- 			enabled = false,
-- 			show_root = true,
-- 		},
-- 		which_key = true,
-- 		bufferline = true,
-- 		markdown = false,
-- 		lightspeed = false,
-- 		ts_rainbow = false,
-- 		hop = false,
-- 	},
-- })
-- vim.cmd([[colorscheme catppuccino]])

vim.g.solarized_termtrans = 1
vim.cmd([[colorscheme solarized-flat]])

vim.api.nvim_command([[augroup Color]])
vim.api.nvim_command([[autocmd!]])
vim.api.nvim_command([[au ColorScheme * hi LineNr guibg=NONE guifg=##FDEBC3]])
vim.api.nvim_command([[au ColorScheme * hi CursorLineNr guifg=#fafafa]])
vim.api.nvim_command([[au ColorScheme * hi Pmenu ctermbg=none guibg=none]])
vim.api.nvim_command([[au ColorScheme * hi EndOfBuffer guibg=NONE guifg=#191C25]])
vim.api.nvim_command([[au ColorScheme * hi CursorLine term=bold cterm=bold guibg=#373f47]])
vim.api.nvim_command([[augroup END]])

-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_transparent = true
-- vim.cmd([[colorscheme tokyonight]])

vim.cmd([[sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=]])
vim.cmd([[sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=]])
vim.cmd([[sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=]])
vim.cmd([[sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=]])
