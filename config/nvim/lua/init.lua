require("colorizer").setup()

require("gitsigns").setup({})

-- require('which-key').setup {}

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		show_buffer_close_icons = false,
		show_close_icon = false,
	},
})

require("presence"):setup({
	-- Oh gosh i'm fucking evil
	-- Sometimes my genius is almost frightening
	buttons = { { label = "?", url = "https://www.youtube.com/watch?v=h1cs8EEe8Bo" } },
})

require("persistence").setup({})

require("pears").setup()
--
-- require'navigator'.setup({
--   debug = false, -- log output, set to true and log path: ~/.local/share/nvim/gh.log
--   default_mapping = true,  -- set to false if you will remap every key
--   keymaps = {{key = "gK", func = "declaration()"}}, -- a list of key maps
--   -- this kepmap gK will override "gD" mapping function declaration()  in default kepmap
--   -- please check mapping.lua for all keymaps
--   treesitter_analysis = true, -- treesitter variable context
--   transparency = 50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it
--   lsp_installer = false, -- set to true if you would like use the lsp installed by williamboman/nvim-lsp-installer
--   lsp = {
--     code_action = {enable = true, sign = true, sign_priority = 40, virtual_text = false},
--     code_lens_action = {enable = true, sign = true, sign_priority = 40, virtual_text = false},
--     format_on_save = true, -- set to false to disasble lsp code format on save (if you are using prettier/efm/formater etc)
--     diagnostic_scroll_bar_sign = {'▃', '▆', '█'}, -- experimental:  diagnostic status in scroll bar area; set to nil to disable the diagnostic sign,
--     -- for other style, set to {'╍', 'ﮆ'} or {'-', '='}
--     diagnostic_virtual_text = true,  -- show virtual for diagnostic message
--     diagnostic_update_in_insert = false, -- update diagnostic message in insert mode
--     disply_diagnostic_qf = true, -- always show quickfix if there are diagnostic errors, set to false if you  want to ignore it
--   }
-- })
