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
    buttons = false,
})

require("surround").setup({ mappings_style = "surround", map_insert_mode = false, prompt = false })

require("nvim-autopairs").setup({ map_cr = true })

local Path = require("plenary.path")
require("session_manager").setup({
    autoload_mode = false,
    autosave_last_session = true, -- Automatically save last session on exit and on session switch.
    autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        "gitcommit",
        "alpha",
        "checkhealth",
        "",
    },
})
